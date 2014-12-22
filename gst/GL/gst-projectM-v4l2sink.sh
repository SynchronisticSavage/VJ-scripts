#!/bin/bash
#script to pipe projectM audio visualizations to a v4l2loopback device

#set video out device
DEV=/dev/video4

#set resolution
WIDTH=640
HEIGHT=480

gst-launch pulsesrc ! libvisual_gl_projectM ! gldownload ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT ! v4l2sink device=$DEV

