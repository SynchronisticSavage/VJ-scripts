#!/bin/bash
#script to pipe vlc to v4l2loopback device

#set output video device
ODEV=/dev/video3
mkfifo /tmp/vlcpipe
yuv4mpeg_to_v4l2 $ODEV < /tmp/vlcpipe
vlc --yuv-file=/tmp/vlcpipe --yuv-yuv4mpeg2 --canvas-width=640 --canvas-height=480 --width=640 --height=480
#vlc --yuv-file=/tmp/vlcpipe --yuv-yuv4mpeg2 --width=640 --height=480

