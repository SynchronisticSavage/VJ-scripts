#! /bin/bash
#script to stream desktop area over udp multicast using jpeg encoding good for streaming low latency decent quality video over a wired LAN, think sending streams from one stage at a festival to another.

#set desktop capture area
STARTX=0
STARTY=0
ENDX=639
ENDY=479
#show cursor?
POINTER=false

#set resolution
WIDTH=640
HEIGHT=480
#set multicast IP and udp port number
IP=10.42.0.255
VPORT=5000
#FRAMERATE=30/1

gst-launch -v ximagesrc show-pointer=$POINTER use-damage=0 startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT ! ffmpegcolorspace ! jpegenc ! udpsink host=$IP port=$VPORT sync=false auto-multicast=true

