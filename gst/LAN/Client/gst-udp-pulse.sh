#!/bin/bash
#Open to Source
#a script to send sound from pulse audio over a network multicast

IP=192.168.1.255
APORT=7777

gst-launch-0.10 -v udpsrc multicast-group=$IP auto-multicast=true port=$APORT ! mad ! pulsesink

