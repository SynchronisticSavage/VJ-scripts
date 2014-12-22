#!/bin/bash
#script to pipe projectM audio visualizations to a v4l2loopback device

#set video out device
DEV=/dev/video4

#set resolution
WIDTH=640
HEIGHT=480

#set audio source
#ASRC=jackaudiosrc
ASRC=pulsesrc

gst-launch $ASRC ! libvisual_gl_projectM ! gldownload ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT ! v4l2sink device=$DEV

