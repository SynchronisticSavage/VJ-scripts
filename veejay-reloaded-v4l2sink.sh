#!/bin/bash
#script to launch veejay and reloaded

#set resolution and framerate
WIDTH=640
HEIGHT=480
FPS=30

#set audio rate
ARATE=48000

#set veejay output v4l2loopback device
ODEV=/dev/video7

#load v4l2loopback kernel module (comment out if you set it to autoload)
sudo modprobe v4l2loopback devices=8
mkfifo /tmp/pipe

#!WORKAROUND! pipe /dev/video1 (PS3 Eye) to /dev/video2 so it will work with Veejay
#gst-launch v4l2src device=/dev/video1 ! v4l2sink device=/dev/video7 &

#pipe /tmp/pipe to output Veejay to ODEV
yuv4mpeg_to_v4l2 $ODEV < /tmp/pipe &
#start VeeJay Server with options to output 640x480 to /dev/video3 via /tmp/pipe
veejay --audiorate $ARATE --fps $FPS --output 4 --output-file /tmp/pipe -w $WIDTH -h $HEIGHT -W $WIDTH -H $HEIGHT -N 1 &

#start reloaded VJ Client

reloaded

