#! /bin/bash
#Written by Garrett Weaver
#Supermodified by Open to Source
#Licensed under GNU GPL version 3
#This script transmits audio and video over UDP multi-cast with ASV2 encoding
#Asus Video 2 seems to be semi-lite on the cpu/network with good quality

#set desktop capture area
STARTX=0
STARTY=0
ENDX=1023
ENDY=767
#show cursor?
POINTER=false


#set input resolution and framerate
INWIDTH=1024
INHEIGHT=768
FPS=30/1

#set output resolution
WIDTH=640
HEIGHT=480

#FPS=30000/1001

#set IP addy and port number
IP=10.42.0.255
VPORT=5000 
#APORT=5001

gst-launch-0.10 -v ximagesrc show-pointer=$POINTER use-damage=0 startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! queue !  video/x-raw-rgb,width=$INWIDTH,height=$INHEIGHT,framerate=$FPS ! videoscale ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT ! ffenc_asv2 ! udpsink host=$IP port=$VPORT auto-multicast=true sync=true

#audio transmit uncomment to enable
#gst-launch-0.10 -v alsasrc ! audioconvert ! vorbisenc ! rtpvorbispay ! udpsink host=$IP port=$APORT auto-multicast=true
