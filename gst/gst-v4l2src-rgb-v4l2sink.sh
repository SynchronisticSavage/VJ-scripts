#!/bin/bash
#script to convert v4l2 stream to veejay compatable format
INDEV=/dev/video5
ODEV=/dev/video7
gst-launch v4l2src device=$INDEV ! video/x-raw-rgb ! v4l2sink device=$ODEV

#gst-launch v4l2src device=$INDEV ! video/x-raw-yuv,format='(fourcc)'YUY2,framerate=30/1 ! v4l2sink device=$ODEV

