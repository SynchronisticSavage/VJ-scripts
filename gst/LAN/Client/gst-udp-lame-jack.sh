#!/bin/bash
#Open to Source
#a script to send sound from pulse audio over a network multicast
#removed multicast-group=$IP
IP=192.168.1.255
APORT=7777

gst-launch-0.10 -v udpsrc auto-multicast=true port=$APORT ! mad ! audioconvert ! jackaudiosink

