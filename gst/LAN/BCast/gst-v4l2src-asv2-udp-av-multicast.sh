#! /bin/bash
#Written by Garrett Weaver
#Licensed under GNU GPL version 3
#This script transmits video over UDP

IP=10.42.0.255
VPORT=5555

#APORT=5001

gst-launch -v v4l2src device=/dev/video7 ! ffmpegcolorspace ! ffenc_asv2 ! udpsink host=$IP port=$VPORT auto-multicast=true sync=false

#audio transmit
#gst-launch-0.10 -v alsasrc ! audioconvert ! vorbisenc ! rtpvorbispay ! udpsink host=$IP port=$APORT auto-multicast=true
