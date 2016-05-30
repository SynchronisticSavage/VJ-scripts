#! /bin/bash
#script to stream desktop area over udp multicast using x264 encoding good for streaming low latency decent quality video over a wired LAN, think sending streams from one stage at a festival to another.

#set desktop capture area
STARTX=0
STARTY=0
ENDX=639
ENDY=479
#show cursor?
POINTER=false

#set input resolution and framerate
INWIDTH=640
INHEIGHT=480
FPS=30/1
#set output resolution
WIDTH=640
HEIGHT=480

#set multicast IP and port
IP=192.168.0.255
VPORT=5001
#FRAMERATE=30/1
# speed-preset=1 
gst-launch-1.0 -v ximagesrc show-pointer=$POINTER use-damage=0 startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! queue ! video/x-raw,width=$INWIDTH,height=$INHEIGHT,framerate=$FPS ! videoscale ! videoconvert ! video/x-raw,width=$WIDTH,height=$HEIGHT ! x264enc tune=0x00000004 ! rtph264pay ! udpsink host=$IP port=$VPORT auto-multicast=true sync=false

