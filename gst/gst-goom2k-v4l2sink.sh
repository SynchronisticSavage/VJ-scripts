#!/bin/bash
#send goom2k1 audio visualizations to v4l2loopback
ASRC=pulsesrc
WIDTH=640
HEIGHT=480
VOUT=/dev/video7
gst-launch $ASRC ! queue ! audioconvert ! goom2k1 ! video/x-raw-rgb,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! ffmpegcolorspace ! queue ! v4l2sink device=$VOUT

