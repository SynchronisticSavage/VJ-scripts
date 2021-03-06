#! /bin/bash
#Written by Garrett Weaver
#modded by Open to Source
#Licensed under GNU GPL version 3
#This script receives and display video on v4l2loopback device through UDP

#set IP and Port
IP=10.42.0.255
VPORT=5003
#set Latency
LATENCY=2
#set v4l2loopback video dev multicast-group=$IP auto-multicast=true
VIDEV=/dev/video6
gst-launch-1.0 udpsrc multicast-group=$IP auto-multicast=true port=$VPORT caps=application/x-rtp,payload=96 ! rtpjitterbuffer drop-on-latency=false latency=$LATENCY ! rtph264depay ! avdec_h264 ! videoconvert ! v4l2sink device=$VIDEV sync=false

