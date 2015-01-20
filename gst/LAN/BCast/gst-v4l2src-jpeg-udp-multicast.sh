#! /bin/bash
#script to stream v4l2 device over udp multicast using jpeg encoding good for streaming low latency decent quality video over a wired LAN, think sending streams from one stage at a festival to another.

#set v4l2 input device
IDEV=/dev/video5

#set resolution
WIDTH=640
HEIGHT=480

#set multicast IP and udp port number
IP=10.42.0.255
VPORT=5000
#FRAMERATE=30/1

gst-launch -v v4l2src device=$IDEV ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT ! ffmpegcolorspace ! jpegenc ! udpsink host=$IP port=$VPORT sync=false auto-multicast=true

