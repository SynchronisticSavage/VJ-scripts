#!/bin/bash
#script to pipe desktop to v4l2loopback device

#set the v4l2 output device
VDEV=/dev/video4
#set the capture area
CAPZONE=640x480
FPS=30
mkfifo /tmp/deskpipe
yuv4mpeg_to_v4l2 /dev/video4 < /tmp/deskpipe &

ffmpeg -f x11grab -follow_mouse centered -r $FPS -s $CAPZONE -i :0.0+0,0 -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f yuv4mpegpipe /tmp/deskpipe
