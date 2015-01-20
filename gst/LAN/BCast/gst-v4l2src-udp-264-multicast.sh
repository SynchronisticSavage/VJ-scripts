#! /bin/bash
#Written by Garrett Weaver
#modded by Open to Source
#Licensed under GNU GPL version 3
#This script transmits video encoded with x264 over UDP

#set v4l2 Input device
IDEV=/dev/video5

#set resolution and framerate
WIDTH=640
HEIGHT=480
FPS=30/1

#set the Multicast IP network and port number
IP=10.42.0.255
VPORT=5000


#video transmit
gst-launch-0.10 -v v4l2src device=$IDEV ! queue ! video/x-raw-rgb,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! ffmpegcolorspace ! x264enc bitrate=4444 speed-preset=1 tune=zerolatency ! queue ! rtph264pay ! udpsink host=$IP port=$VPORT auto-multicast=true 

