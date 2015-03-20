#!/bin/bash
#script to launch veejay and reloaded

#set resolution and framerate
WIDTH=1280
HEIGHT=720
FPS=30

#set audio rate
ARATE=48000
#ARATE=44100
#set veejay output v4l2loopback device
ODEV=5

#load v4l2loopback kernel module (comment out if you set it to autoload)
#sudo modprobe v4l2loopback devices=8
#make first in first out tmp file
mkfifo /tmp/pipe	

#!WORKAROUND! pipe /dev/video1 (PS3 Eye) to /dev/video2 so it will work with veejay, (seems to be fixed with recent versions)
#gst-launch v4l2src device=/dev/video1 ! v4l2sink device=/dev/video2 &

#pipe /tmp/pipe to output Veejay to ODEV
yuv4mpeg_to_v4l2 /dev/video$ODEV < /tmp/pipe &

echo "starting veejay with a resolution of $WIDTH x $HEIGHT at $FPS frames per second"
echo "setting audiorate to: $ARATE"

veejay -v --audiorate $ARATE --fps $FPS --output 4 --output-file /tmp/pipe -w $WIDTH -h $HEIGHT -W $WIDTH -H $HEIGHT -N 1 &

#start reloaded VJ Client

reloaded

