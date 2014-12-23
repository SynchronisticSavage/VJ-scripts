#! /bin/bash
#Written by Garrett Weaver
#modded by Open to Source
#Licensed under GNU GPL version 3
#This script receives and display video on v4l2loopback device through UDP

#set IP and Port
IP=10.42.0.255
VPORT=5000
#set Latency
LATENCY=2
#set v4l2loopback video dev
VIDEV=/dev/video5
gst-launch-0.10 udpsrc multicast-group=$IP auto-multicast=true port=$VPORT caps=application/x-rtp ! gstrtpjitterbuffer drop-on-latency=false latency=$LATENCY ! rtph264depay queue-delay=0 ! ffdec_h264 ! ffmpegcolorspace ! v4l2sink device=$VIDEV sync=false

