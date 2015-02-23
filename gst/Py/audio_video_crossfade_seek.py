#!/usr/bin/env python

"""A short Audio-Video example"""
import gobject
gobject.threads_init()
import gst
import pygtk
pygtk.require("2.0")
import gtk
import sys
import os
from audio_video import AVDemo, create_decodebin

class AVCrossfade(AVDemo):
    """Base class implementing boring, boiler-plate code.
    Sets up a basic gstreamer environment which includes:

    * a window containing a drawing area and basic media controls
    * a basic gstreamer pipeline using an ximagesink and an autoaudiosink
    * connects the ximagesink to the window's drawing area

    Derived classes need only override magic(), __name__,
    and __usage__ to create new demos."""

    __name__ = "AV Demo"
    __usage__ = "python audio_video.py <filename>"
    __def_win_size__ = (640, 480)

    # this commment allows us to include only a portion of the file
    # in the tutorial for this demo

    def onPad(self, decoder, pad, target):
        tpad = target.get_compatible_pad(pad)
        if tpad:
            pad.link(tpad)

    def addVideoChain(self, pipeline, name, decoder, mixer):
        alpha = gst.element_factory_make("alpha")
        alpha.props.alpha = 1.0
        videoscale = gst.element_factory_make("videoscale")
        videorate = gst.element_factory_make("videorate")
        colorspace = gst.element_factory_make("ffmpegcolorspace")
        queue = gst.element_factory_make("queue")

        pipeline.add(alpha, videoscale, videorate, colorspace, queue)
        decoder.connect("pad-added", self.onPad, videorate)
        videorate.link(videoscale)
        videoscale.link(colorspace)
        colorspace.link(queue)
        queue.link(alpha)
        alpha.link(mixer)
        setattr(self, "decoder%s" % name, decoder)
        setattr(self, "alpha%s" % name, alpha)

    def addAudioChain(self, pipeline, name, decoder, adder):
        volume = gst.element_factory_make("volume")
        volume.props.volume = 0.5
        audioconvert = gst.element_factory_make("audioconvert")
        audiorate = gst.element_factory_make("audioresample")
        queue = gst.element_factory_make("queue")

        pipeline.add(volume, audioconvert, audiorate, queue)
        decoder.connect("pad-added", self.onPad, audioconvert)
        audioconvert.link(audiorate)
        audiorate.link(queue)
        queue.link(volume)
        volume.link(adder)

        setattr(self, "vol%s" % name, volume)

    def addSourceChain(self, pipeline, name, filename, mixer, adder):
        src = gst.element_factory_make("souphttpsrc")
        src.props.location = filename
        #dcd = create_decodebin()
	dcd = gst.element_factory_make("decodebin2")
	#dcd.seek_simple(10)
	#dcd.seek_simple(gst.FORMAT_TIME, gst.SEEK_FLAG_FLUSH, 0)
	dcd.seek_simple(gst.FORMAT_TIME, gst.SEEK_FLAG_FLUSH | gst.SEEK_FLAG_KEY_UNIT, 100 * gst.SECOND)
	#src.seek_simple(gst.FORMAT_TIME, gst.SEEK_FLAG_SEGMENT, 500)
	#pipeline.seek_simple (gst.FORMAT_TIME, gst.SEEK_FLAG_NONE, 15);
	#src.get_pad("src").push_event(gst.event_new_flush_start())
	#src.get_pad("src").push_event(gst.event_new_flush_stop())

        pipeline.add(src, dcd)
        src.link(dcd)
        self.addVideoChain(pipeline, name, dcd, mixer)
        self.addAudioChain(pipeline, name, dcd, adder)
    
    def magic(self, pipeline, (videosink, audiosink), args):
        """This is where the magic happens"""
        mixer = gst.element_factory_make("videomixer")
        adder = gst.element_factory_make("adder")
        pipeline.add(mixer, adder)
	pipeline.seek_simple(gst.FORMAT_TIME, gst.SEEK_FLAG_SEGMENT, 5000)

        mixer.link(videosink)
        adder.link(audiosink)
        self.addSourceChain(pipeline, "A", args[0], mixer, adder)
        self.addSourceChain(pipeline, "B", args[1], mixer, adder)
        self.alphaB.props.alpha = 0.5

    def _on_seeker_press_cb(self, widget, event):
        self.slider_being_used = True
        if event.type == Gdk.EventType.BUTTON_PRESS:
            self.countinuous_seek = True
            if self.is_playing:
                self.player.setState(Gst.State.PAUSED)
        elif event.type == Gdk.EventType.BUTTON_RELEASE:
            self.countinuous_seek = False
            value = int(widget.get_value())
            self.player.simple_seek(value)
            if self.is_playing:
                self.player.setState(Gst.State.PLAYING)
            # Now, allow gobject timeout to continue updating the slider pos:
            self.slider_being_used = False
	
    def onValueChanged(self, adjustment):
        balance = self.balance.get_value()
        crossfade = self.crossfade.get_value()
	seek = self.seek.get_value()

        self.volA.props.volume = (2 - balance) * (1 - crossfade)
        self.volB.props.volume = balance * crossfade
        self.alphaB.props.alpha = crossfade
	#pipeline.seek_simple(gst.FORMAT_TIME, gst.SEEK_FLAG_FLUSH | gst.SEEK_FLAG_KEY_UNIT, seek * gst.SECOND)

	#seek_event = gst.event_new_seek (1, GST_FORMAT_TIME, GST_SEEK_FLAG_FLUSH, GST_SEEK_TYPE_SET, seek , GST_SEEK_TYPE_SET, 0 ); 

        #dcd = create_decodebin()
	#seek_time_secs = seek.get_value()	
	#self.seek_simpleA(gst.FORMAT_TIME, gst.SEEK_FLAG_FLUSH | gst.SEEK_FLAG_KEY_UNIT, seek * gst.SECOND)

    def customWidgets(self):

	self.seek = gtk.Adjustment(0.0, 0, 1.0)	


        self.crossfade = gtk.Adjustment(0.5, 0, 1.0)
        self.balance = gtk.Adjustment(1.0, 0.0, 2.0)

        crossfadeslider = gtk.HScale(self.crossfade)
        balanceslider = gtk.HScale(self.balance)
	seekslider = gtk.HScale(self.seek)

        self.seek.connect("value-changed", self.onValueChanged)
        self.crossfade.connect("value-changed", self.onValueChanged)
        self.balance.connect("value-changed", self.onValueChanged)

        ret = gtk.Table()

        ret.attach(gtk.Label("Seeker"), 0, 1, 0, 1)
        ret.attach(seekslider, 1, 2, 0, 1)
	
        #ret.attach(gtk.Label("Crossfade"), 0, 1, 0, 1)
        #ret.attach(crossfadeslider, 1, 2, 0, 1)

        ret.attach(gtk.Label("Crossfade"), 0, 1, 1, 2)
        ret.attach(crossfadeslider, 1, 2, 1, 2)
        
	#ret.attach(gtk.Label("Balance"), 0, 1, 1, 2)
        #ret.attach(balanceslider, 1, 2, 1, 2)

	ret.attach(gtk.Label("Balance"), 0, 1, 2, 3)
        ret.attach(balanceslider, 1, 2, 2, 3)
        return ret

# if this file is being run directly, create the demo and run it
if __name__ == '__main__':
    AVCrossfade().run()
