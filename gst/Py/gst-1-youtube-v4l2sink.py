#!/usr/bin/env python
  
import pygst
pygst.require("1.0")
import gst
import gtk
import time
#python script to pipe youtube video through v4l2loopback
#gst-launch-0.10 uridecodebin name=dec uri=$(/usr/bin/youtube-dl -g -f 18 $VID)  ! queue ! autoaudiosink dec. ! queue ! videoscale ! videorate ! videoconvert ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FPS,format=\(fourcc\)YUY2 !  v4l2sink device=$DEV

class Pipeline(object):
    def __init__(self):
        self.pipeline = gst.Pipeline("pipe")

        self.webcam = gst.element_factory_make("uridecodebin", "webcam")
        self.webcam.set_property("name", "dec")
        self.webcam.set_property("uri", "https://r7---sn-uxa0n-t8ge.googlevideo.com/videoplayback?upn=NfyzW9GP_rI&sparams=dur%2Cid%2Cinitcwndbps%2Cip%2Cipbits%2Citag%2Cmime%2Cmm%2Cms%2Cmv%2Cpl%2Cratebypass%2Crequiressl%2Csource%2Cupn%2Cexpire&mt=1423607359&mv=m&initcwndbps=1680000&itag=18&ms=au&mm=31&ipbits=0&fexp=907263%2C927622%2C934954%2C9405957%2C9406352%2C9406653%2C943917%2C947225%2C948124%2C951703%2C952302%2C952605%2C952612%2C952901%2C955301%2C957201%2C959701&id=o-AKTOF81wFSr82qnYzE4MeBw61iMriU75FOhA9tHvlJca&sver=3&ip=207.34.141.22&requiressl=yes&signature=1E2427505D722028BBC73A7A6433E59C63AD7E21.B9BF9D4F68425C001182903082E6D1B3A4140502&key=yt5&source=youtube&ratebypass=yes&dur=64.760&expire=1423629184&mime=video%2Fmp4&pl=17")
        self.pipeline.add(self.webcam)

	self.queue = gst.element_factory_make("queue", "queue")
        self.pipeline.add(self.queue)
	
	self.audio = gst.element_factory_make("autoaudiosink", "audio")
        self.pipeline.add(self.audio)
	self.dec = gst.element_get_name(self.webcam)
	self.pipeline.add(self.dec)
	self.que = gst.element_factory_make("queue", "que")
        self.pipeline.add(self.que)

	self.videoscale = gst.element_factory_make("videoscale", "videoscale")
        self.pipeline.add(self.videoscale)

	self.videorate = gst.element_factory_make("videorate", "videorate")
        self.pipeline.add(self.videorate)

	self.videoconvert = gst.element_factory_make("videoconvert", "videoconvert")
        self.pipeline.add(self.videoconvert)


        self.caps_filter = gst.element_factory_make("capsfilter", "caps_filter")
        caps = gst.Caps("video/x-raw,width=640,height=480,framerate=30/1")
        #caps = gst.Caps("video/x-raw-yuv,width=640,height=480,framerate=30/1,format=\(fourcc\)YUY2")
        self.caps_filter.set_property("caps", caps)
        self.pipeline.add(self.caps_filter)
  
        self.sink = gst.element_factory_make("v4l2sink", "sink")
	self.sink.set_property("device", "/dev/video3")
        self.pipeline.add(self.sink)

	self.webcam.link(self.queue)
	self.queue.link(self.audio)
	self.audio.link(self.dec)
	self.dec.link(self.que)
	self.que.link(self.videoscale)
	self.videoscale.link(self.videorate)
	self.videorate.link(self.videoconvert)
	self.videoconvert.link(self.caps_filter)
	self.caps_filter.link(self.sink)

	#self.webcam.link(self.caps_filter)

        #self.caps_filter.link(self.ffmcs)
	#self.ffmcs.link(self.kscope)
	#self.kscope.link(self.ffmc2)
	#self.ffmc2.link(self.sink)
	print "got here"
        self.pipeline.set_state(gst.STATE_PLAYING)
	#time.sleep(3)

  
start = Pipeline()

gtk.main()


