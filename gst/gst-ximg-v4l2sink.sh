#!/bin/bash
#script to pipe desktop area to v4l2loopback device.  usefull for streaming to multiple video/vj programs
#hint...think virtual feedback

#set capture area
STARTX=0
STARTY=0
ENDX=1023
ENDY=767

#show cursor?
POINTER=false

#set resolution and framerate
WIDTH=1024
HEIGHT=768
FPS=30/1


#FMAT=I420


gst-launch -v ximagesrc use-damage=0 show-pointer=$POINTER startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! ffmpegcolorspace ! videoscale ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! v4l2sink device=/dev/video4
