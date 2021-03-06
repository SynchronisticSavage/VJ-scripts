#!/usr/bin/env python
  
import pygst
pygst.require("0.10")
import gst
import gtk
import time
#kaleidoscope 
#gst-launch v4l2src device=/dev/video1 ! video/x-raw-yuv,width=640,height=480,framerate=30/1 ! ffmpegcolorspace ! kaleidoscope ! ffmpegcolorspace ! xvimagesink

class Pipeline(object):
    def __init__(self):
        self.pipeline = gst.Pipeline("pipe")

        self.webcam = gst.element_factory_make("v4l2src", "webcam")
        self.webcam.set_property("device", "/dev/video5")
        self.pipeline.add(self.webcam)



        self.caps_filter = gst.element_factory_make("capsfilter", "caps_filter")
        caps = gst.Caps("video/x-raw-yuv,width=640,height=480")
        self.caps_filter.set_property("caps", caps)
        self.pipeline.add(self.caps_filter)

	self.ffmcs = gst.element_factory_make("ffmpegcolorspace", "ffmcs")
	self.pipeline.add(self.ffmcs)
  
	self.kscope = gst.element_factory_make("kaleidoscope", "kscope")
	self.kscope.set_property("sides", 4)
	self.pipeline.add(self.kscope)

	self.ffmc2 = gst.element_factory_make("ffmpegcolorspace", "ffmc2")
	self.pipeline.add(self.ffmc2)

        self.sink = gst.element_factory_make("v4l2sink", "sink")
	self.sink.set_property("device", "/dev/video6")
        self.pipeline.add(self.sink)
  
        self.webcam.link(self.caps_filter)

        self.caps_filter.link(self.ffmcs)
	self.ffmcs.link(self.kscope)
	self.kscope.link(self.ffmc2)
	self.ffmc2.link(self.sink)
	time.sleep(3)
	print "first sleep"
        self.pipeline.set_state(gst.STATE_PLAYING)
	time.sleep(3)
	print "second sleep"
	self.pipeline.set_state(gst.STATE_PAUSED)
	print "third sleep"
	time.sleep(3)
        self.pipeline.set_state(gst.STATE_PLAYING)
	time.sleep(3)
	print "second sleep"
	self.pipeline.set_state(gst.STATE_STOPPED)
	print "third sleep"
	time.sleep(3)
        self.pipeline.set_state(gst.STATE_PLAYING)
	time.sleep(3)
	print "second sleep"
	self.pipeline.set_state(gst.STATE_PAUSED)
	print "third sleep"
	time.sleep(3)
        self.pipeline.set_state(gst.STATE_PLAYING)
	time.sleep(3)
	print "second sleep"
	self.pipeline.set_state(gst.STATE_PAUSED)
	print "third sleep"
	time.sleep(3)
        self.pipeline.set_state(gst.STATE_PLAYING)

  
start = Pipeline()

gtk.main()


