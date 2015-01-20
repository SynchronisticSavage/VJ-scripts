#!/bin/bash
#script to pipe desktop area to v4l2loopback device.  usefull for streaming to multiple video/vj programs
#hint...think virtual feedback

#set capture area
XID=0x440000e
SNUM=99
#show cursor?
POINTER=false

#set resolution and framerate
WIDTH=640
HEIGHT=480
FPS=60/1
#set v4l2 output
VDEV=/dev/video3

#FMAT=I420


gst-launch -v ximagesrc screen-num=$SNUM use-damage=0 show-pointer=$POINTER xid=$XID ! video/x-raw-rgb,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! ffmpegcolorspace ! videoscale ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! xvimagesink
