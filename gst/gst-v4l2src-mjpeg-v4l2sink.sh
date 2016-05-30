#!/bin/bash
#script to convert v4l2 stream to veejay compatable format
INDEV=/dev/video8
ODEV=/dev/video3
gst-launch-0.10 -v v4l2src device=$INDEV ! ffmpegcolorspace ! jpegenc ! image/jpeg,width=1280,height=720 ! v4l2sink device=$ODEV

#gst-launch v4l2src device=$INDEV ! video/x-raw-yuv,format='(fourcc)'YUY2,framerate=30/1 ! v4l2sink device=$ODEV

