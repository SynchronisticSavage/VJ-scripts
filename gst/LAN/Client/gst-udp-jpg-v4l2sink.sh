#! /bin/bash
#Written by Garrett Weaver
#modded by Open to SOurce
#Licensed under GNU GPL version 3
#This script receive video encoded with asusv2 video through UDP and pipes to v4l2loopback device
#to be tested

#set multicast IP range and UDP port number
IP=10.42.0.255
VPORT=5000

#set latency
LATENCY=1
#set output video device
VIDEODEV=/dev/video8

gst-launch udpsrc multicast-group=$IP auto-multicast=true port=$VPORT ! jpegdec ! ffmpegcolorspace ! queue ! v4l2sink device=$VIDEODEV sync=false


