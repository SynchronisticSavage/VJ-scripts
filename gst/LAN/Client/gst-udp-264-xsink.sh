#! /bin/bash
#Written by Garrett Weaver
#Licensed under GNU GPL version 3
#This script receives and displays video through UDP

#set IP and Port
IP=10.42.0.255
VPORT=5000

#set latency
LATENCY=200

gst-launch-0.10 udpsrc multicast-group=$IP auto-multicast=true port=$VPORT caps=application/x-rtp ! gstrtpjitterbuffer drop-on-latency=false latency=$LATENCY ! rtph264depay queue-delay=0 ! ffdec_h264 ! ffmpegcolorspace ! ximagesink sync=true 


