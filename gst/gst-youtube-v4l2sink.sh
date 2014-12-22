#!/bin/bash
#script to stream youtube video to v4l2loopback device

#gst-launch-0.10 uridecodebin name=dec uri=$(/usr/bin/youtube-dl -g -f 18 WVaxuIKPKvU)  ! queue ! autoaudiosink dec. ! queue  ! videoscale ! video/x-raw-yuv,width=1024,height=768 ! autovideosink

#set Video ID Get from youtube video url after watch?v=
#VID=WVaxuIKPKvU

#or set it from the comand line
VID=$1


#set width and height of v4l2loopback streaming
WIDTH=640
HEIGHT=480
FPS=30/1

#set output video device
DEV=/dev/video5

gst-launch-0.10 uridecodebin name=dec uri=$(/usr/bin/youtube-dl -g -f 18 $VID)  ! queue ! autoaudiosink dec. ! queue  ! videoscale ! videorate ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! v4l2sink device=$DEV

