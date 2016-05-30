#! /bin/bash
#Written by Garrett Weaver
#modded by Open to Source
#Licensed under GNU GPL version 3
#This script transmits asv2 encoded video over UDP

#set Multicast IP Area and Video port
IP=192.168.0.255
VPORT=5000
#set v4l2 input device
DEVICE=/dev/video5

gst-launch-1.0 -v v4l2src device=$DEVICE ! videoconvert ! avenc_asv2 ! udpsink host=$IP port=$VPORT auto-multicast=true sync=false

