#!/bin/bash
#script to pipe desktop area to v4l2loopback device.  usefull for streaming to multiple video/vj programs
#hint...think virtual feedback

#set capture area
XID=0x400000e
#show cursor?
POINTER=false

#set resolution and framerate
WIDTH=640
HEIGHT=480
FPS=30/1


#FMAT=I420


gst-launch -v ximagesrc use-damage=0 show-pointer=$POINTER xid=$XID ! ffmpegcolorspace ! videoscale ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! v4l2sink device=/dev/video4
