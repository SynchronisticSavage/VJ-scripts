#! /bin/bash
#Written by Garrett Weaver
#modded by Open to SOurce
#Licensed under GNU GPL version 3
#This script receive video encoded with asusv2 video through UDP and pipes to v4l2loopback device

#set multicast IP range and UDP port number
IP=192.168.1.255
VPORT=123456
#set latency
LATENCY=1
#set output video device
VIDEODEV=/dev/video3

gst-launch-0.10 udpsrc multicast-group=$IP auto-multicast=true port=$VPORT caps="video/x-asus, width=(int)640, height=(int)480, framerate=(fraction)25/1, asusversion=(int)2, codec_data=(buffer)1000000041535553" ! ffdec_asv2 ! ffmpegcolorspace ! v4l2sink device=$VIDEODEV sync=false

