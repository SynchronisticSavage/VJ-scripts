#!/bin/bash

#Script to capture desktop to avi file playable in Veejay

#set Encoder

ENC=jpegenc
#ENC=x264enc

#set output path and file
VPATH=~/Videos/capture
OFILE=gst-ximg-pulse-mjpg.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set ximgsrc capture area and original resolution
XID=0x3a00002
#show cursor?
POINTER=false

#set Output Width/Height (scale)
WIDTH=1024
HEIGHT=768

#set your Audio Source
#ASRC=jackaudiosrc
ASRC=autoaudiosrc
#ASRC=pulsesrc

gst-launch-0.10 -e ximagesrc use-damage=0 show-pointer=$POINTER xid=$XID ! queue ! videoscale ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! queue ! $ENC ! avimux name=mux ! filesink location=$VPATH/$TIME.$OFILE $ASRC ! queue ! audioconvert ! 'audio/x-raw-int,rate=48000,channels=2' ! mux.
