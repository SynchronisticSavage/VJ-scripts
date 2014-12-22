#!/bin/bash
#simple script to visualize sound and output to v4l2loopback device

#set audio src
#ASRC=jackaudiosrc
ASRC=pulsesrc

#set resolution
WIDTH=640
HEIGHT=480

#set v4l2 video out device
ODEV=/dev/video5

#run the pipe
gst-launch $ASRC ! queue ! audioconvert ! wavescope ! video/x-raw-rgb,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! ffmpegcolorspace ! queue ! v4l2sink device=$ODEV

