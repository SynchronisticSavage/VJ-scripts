#! /bin/bash
#Written by Garrett Weaver
#Licensed under GNU GPL version 3
#This script receives and displays video encoded with asus video 2 through UDP

#set multicast IP range and Port number
IP=10.42.0.255
VPORT=5000
#set latency
LATENCY=1


gst-launch-1.0 udpsrc multicast-group=$IP auto-multicast=true port=$VPORT caps="video/x-asus, width=(int)640, height=(int)480, framerate=(fraction)24/1, asusversion=(int)2, codec_data=(buffer)1000000041535553" ! avdec_asv2 ! ximagesink sync=false

