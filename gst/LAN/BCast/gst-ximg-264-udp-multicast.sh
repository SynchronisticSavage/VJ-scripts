#! /bin/bash
#script to stream desktop area over udp multicast using x264 encoding good for streaming low latency decent quality video over a wired LAN, think sending streams from one stage at a festival to another.

#set desktop capture area
STARTX=0
STARTY=0
ENDX=639
ENDY=479
#show cursor?
POINTER=false

#set width/height
WIDTH=640
HEIGHT=480

#set multicast IP and port
IP=10.42.0.255
VPORT=5000
#FRAMERATE=30/1


#gst-launch -v ximagesrc use-damage=0 startx=0 starty=0 endx=639 endy=479 ! ffmpegcolorspace ! video/x-raw-yuv,width=640,height=480 ! ffmpegcolorspace ! jpegenc ! multipartmux ! udpsink host=10.42.0.1 port=5555
gst-launch -v ximagesrc show-pointer=$POINTER use-damage=0 startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT ! ffmpegcolorspace ! x264enc speed-preset=1 tune=0x00000004 ! rtph264pay ! udpsink host=$IP port=$VPORT auto-multicast=true sync=false


