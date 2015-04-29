#!/bin/bash
#script to convert v4l2 stream to veejay compatable format
INDEV=/dev/video0
ODEV=/dev/video3
#set width and height
WIDTH=640
HEIGHT=480

gst-launch -v v4l2src device=$INDEV ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT ! v4l2sink device=$ODEV

#gst-launch v4l2src device=$INDEV ! video/x-raw-yuv,format='(fourcc)'YUY2,framerate=30/1 ! v4l2sink device=$ODEV

