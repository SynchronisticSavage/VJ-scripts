#!/bin/bash

#Script to capture desktop to avi file playable in Veejay

#set Encoder

ENC=jpegenc
#ENC=x264enc

#set output path and file
VPATH=~/Videos/capture
OFILE=gst-mjpg-ximg.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set ximgsrc capture area
STARTX=0
STARTY=0
ENDX=1023
ENDY=767

VSCALE=videoscale
#VSCALE= 
#set Output Width/Height (scale)
WIDTH=1024
HEIGHT=768

OWIDTH=1024
OHEIGHT=768

#set your Audio Source
#ASRC=jackaudiosrc
ASRC=pulsesrc

gst-launch-0.10 -e ximagesrc use-damage=0 startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! queue ! video/x-raw-rgb,width=$OWIDTH,height=$OHEIGHT,framerate=30/1 ! $VSCALE ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! queue ! $ENC ! avimux name=mux ! filesink location=$VPATH/$TIME.$OFILE dec. ! audioconvert ! 'audio/x-raw-int,rate=48000,channels=2' ! mux.
