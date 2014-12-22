#! /bin/bash
#Written by Garrett Weaver
#Supermodified by Open to Source
#Licensed under GNU GPL version 3
#This script transmits audio and video over UDP multi-cast with ASV2 encoding
#Asus Video 2 seems to be semi-lite on the cpu/network with good quality

#set desktop capture area
STARTX=0
STARTY=0
ENDX=639
ENDY=479
#show cursor?
POINTER=false

#set width/height and framerate
WIDTH=640
HEIGHT=480
FPS=30000/1001

#set IP addy and port number
IP=10.42.0.255
VPORT=5000 
#APORT=5001

gst-launch-0.10 -v ximagesrc show-pointer=$POINTER use-damage=0 startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! video/x-raw-rgb, width=640, height=480, framerate=$FPS ! ffmpegcolorspace ! ffenc_asv2 ! udpsink host=$IP port=$VPORT auto-multicast=true sync=true

#audio transmit uncomment to enable
#gst-launch-0.10 -v alsasrc ! audioconvert ! vorbisenc ! rtpvorbispay ! udpsink host=$IP port=$APORT auto-multicast=true
