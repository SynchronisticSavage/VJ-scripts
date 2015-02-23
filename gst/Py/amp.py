import gst
import hashlib
import random

from track import Track

class DogError(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)

class Amp():
    def __init__(self, dogvibes):
        self.dogvibes = dogvibes
        self.pipeline = gst.Pipeline ("amppipeline")

        # create the tee element
        self.tee = gst.element_factory_make("tee", "tee")
        self.pipeline.add(self.tee)

        # listen for EOS
        self.bus = self.pipeline.get_bus()
        self.bus.add_signal_watch()
        self.bus.connect('message', self.pipeline_message)

        # create the playqueue
        self.playqueue = []
        self.playqueue_position = 0

        self.src = None

        # set playqueue mode to normal
        self.playqueue_mode = "normal"

        # spotify is special FIXME: not how its supposed to be
        self.spotify = self.dogvibes.sources[0].get_src()
        self.lastfm = self.dogvibes.sources[1].get_src()

    # API

    def API_connectSpeaker(self, nbr):
        nbr = int(nbr)
        if nbr > len(self.dogvibes.speakers) - 1:
            print "Speaker does not exist"

        speaker = self.dogvibes.speakers[nbr];

        if self.pipeline.get_by_name(speaker.name) == None:
            self.sink = self.dogvibes.speakers[nbr].get_speaker();
            self.pipeline.add(self.sink)
            self.tee.link(self.sink)
        else:
            print "Speaker %d already connected" % nbr

    def API_disconnectSpeaker(self, nbr):
        nbr = int(nbr)
        if nbr > len(self.dogvibes.speakers) - 1:
            print "Speaker does not exist"

        speaker = self.dogvibes.speakers[nbr];

        if self.pipeline.get_by_name(speaker.name) != None:
            (pending, state, timeout) = self.pipeline.get_state()
            self.pipeline.set_state(gst.STATE_NULL)
            rm = self.pipeline.get_by_name(speaker.name)
            self.pipeline.remove(rm)
            self.tee.unlink(rm)
            self.pipeline.set_state(state)
        else:
            print "Speaker not connected"

    def API_getAllTracksInQueue(self):
        return [track.__dict__ for track in self.playqueue]

    def API_getPlayedMilliSeconds(self):
        (pending, state, timeout) = self.pipeline.get_state ()
        if (state == gst.STATE_NULL):
            return 0
        (pos, form) = self.pipeline.query_position(gst.FORMAT_TIME)
        return pos / 1000 # / gst.MSECOND # FIXME: something fishy here...

    def API_getStatus(self):
        if (len(self.playqueue) > 0):
            track = self.playqueue[self.playqueue_position]
            status = {'title': track.title,
                      'artist': track.artist,
                      'album': track.album,
                      'duration': int(track.duration),
                      'elapsedmseconds': self.API_getPlayedMilliSeconds()}
            status['index'] = self.playqueue_position
        else:
            status = {}

        # FIXME this should be speaker specific
        status['volume'] = self.dogvibes.speakers[0].get_volume()

        if len(self.playqueue) > 0:
            status['uri'] = self.playqueue[self.playqueue_position].uri
            status['playqueuehash'] = self.get_hash_from_play_queue()
        else:
            status['uri'] = "dummy"
            status['playqueuehash'] = "dummy"

        (pending, state, timeout) = self.pipeline.get_state()
        if state == gst.STATE_PLAYING:
            status['state'] = 'playing'
        elif state == gst.STATE_NULL:
            status['state'] = 'stopped'
        else:
            status['state'] = 'paused'

        return status

    def API_getQueuePosition(self):
        return self.playqueue_position

    def API_nextTrack(self):
        self.change_track(self.playqueue_position + 1)

    def API_playTrack(self, nbr):
        self.change_track(nbr)
        self.API_play()

    def API_previousTrack(self):
        self.change_track(self.playqueue_position - 1)

    def API_play(self):
        if self.playqueue_position > len(self.playqueue) - 1:
            raise DogError, 'Trying to play an empty play queue'
        self.play_only_if_null(self.playqueue[self.playqueue_position])

    def API_pause(self):
        self.pipeline.set_state(gst.STATE_PAUSED)

    def API_queue(self, uri):
        track = self.dogvibes.create_track_from_uri(uri)
        self.playqueue.append(track)

    def API_removeTrack(self, nbr):
        # TODO: rewrite to use id, not index in queue
        nbr = int(nbr)
        if nbr > len(self.playqueue):
            raise DogError, 'Track not removed, playqueue is not that big'

        self.playqueue.remove(self.playqueue[nbr])

        if (nbr <= self.playqueue_position):
            self.playqueue_position = self.playqueue_position - 1

    def API_seek(self, mseconds):
        print "Seek simple to " + mseconds + " useconds"
         # FIXME: this *1000-hack only works for Spotify?
        self.pipeline.seek_simple (gst.FORMAT_TIME, gst.SEEK_FLAG_NONE, int(mseconds) * 1000);
        self.src.get_pad("src").push_event(gst.event_new_flush_start())
        self.src.get_pad("src").push_event(gst.event_new_flush_stop())

    def API_setPlayQueueMode(self, mode):
        if (mode != "normal" and mode != "random" and mode != "repeat" and mode != "repeattrack"):
            raise DogError, "Unknown playqueue mode:" + mode
        self.playqueue_mode = mode

        print self.playqueue_mode

    def API_setVolume(self, level):
        level = float(level)
        if (level > 1.0 or level < 0.0):
            raise DogError, 'Volume must be between 0.0 and 1.0'
        self.dogvibes.speakers[0].set_volume(level)

    def API_stop(self):
        self.pipeline.set_state(gst.STATE_NULL)

    # Internal functions

    def change_track(self, tracknbr):
        tracknbr = int(tracknbr)

        if (self.playqueue_mode == "random"):
            self.playqueue_position = random.randint(0, (len(self.playqueue) - 1))
        elif (self.playqueue_mode == "repeattrack"):
            pass
        elif (tracknbr == self.playqueue_position):
            return
        elif (tracknbr >= 0) and (tracknbr < len(self.playqueue)):
            self.playqueue_position = tracknbr
        elif tracknbr < 0:
            self.playqueue_position = 0
        elif (tracknbr >= len(self.playqueue)) and (self.playqueue_mode == "repeat"):
            self.playqueue_position = 0
        else:
            self.playqueue_position = (len(self.playqueue) - 1)
            self.pipeline.set_state(gst.STATE_NULL)
            return

        (pending, state, timeout) = self.pipeline.get_state()
        self.pipeline.set_state(gst.STATE_NULL)
        self.play_only_if_null(self.playqueue[self.playqueue_position])
        self.pipeline.set_state(state)

    def get_hash_from_play_queue(self):
        ret = ""
        for track in self.playqueue:
            ret += track.uri
        return hashlib.md5(ret).hexdigest()

    def pipeline_message(self, bus, message):
        t = message.type
        if t == gst.MESSAGE_EOS:
            self.API_nextTrack()

    def play_only_if_null(self, track):
        (pending, state, timeout) = self.pipeline.get_state()
        if state != gst.STATE_NULL:
            self.pipeline.set_state(gst.STATE_PLAYING)
            return

        if self.src:
            self.pipeline.remove(self.src)
            if self.spotify_in_use == False:
                print "removed a decodebin"
                self.pipeline.remove(self.decodebin)

        if track.uri[0:7] == "spotify":
            print "It was a spotify uri"
            self.src = self.spotify
            # FIXME ugly
            self.dogvibes.sources[0].set_track(track)
            self.pipeline.add(self.src)
            self.src.link(self.tee)
            self.spotify_in_use = True
        elif track.uri == "lastfm":
            print "It was a lastfm uri"
            self.src = self.lastfm
            self.dogvibes.sources[1].set_track(track)
            self.decodebin = gst.element_factory_make("decodebin2", "decodebin2")
            self.decodebin.connect('new-decoded-pad', self.pad_added)
            self.pipeline.add(self.src)
            self.pipeline.add(self.decodebin)
            self.src.link(self.decodebin)
            self.spotify_in_use = False
        else:
            print "Decodebin is taking care of this uri"
            self.src = gst.element_make_from_uri(gst.URI_SRC, track.uri, "source")
            self.decodebin = gst.element_factory_make("decodebin2", "decodebin2")
            self.decodebin.connect('new-decoded-pad', self.pad_added)
            self.pipeline.add(self.src)
            self.pipeline.add(self.decodebin)
            self.src.link(self.decodebin)
            self.spotify_in_use = False

        self.pipeline.set_state(gst.STATE_PLAYING)

    def pad_added(self, element, pad, last):
        print "Lets add a speaker we found suitable elements to decode"
        pad.link(self.tee.get_pad("sink"))
