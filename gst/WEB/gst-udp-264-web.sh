#!/bin/bash

#set IP and ports
HOST_IP=127.0.0.1
AUDIO_PORT=5008
VIDEO_PORT=5004

#set audio src
#ASRC=alsasrc
ASRC=pulsesrc
gst-launch -e $ASRC ! audio/x-raw-int,rate=8000 ! queue ! voaacenc bitrate=56000 ! rtpmp4apay ! udpsink host=$HOST_IP port=$AUDIO_PORT v4l2src always-copy=false ! "video/x-raw-yuv, width=640, height=480" ! x264enc tune=0x00000004 ! queue ! rtph264pay ! udpsink host=$HOST_IP port=$VIDEO_PORT -v

