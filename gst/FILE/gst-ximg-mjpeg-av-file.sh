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
STARTX=0
STARTY=0
ENDX=639
ENDY=479
OWIDTH=640
OHEIGHT=480
#show cursor?
POINTER=false
DAM=0
#set Output Width/Height (scale)
WIDTH=640
HEIGHT=480

#set your Audio Source
ASRC=jackaudiosrc
#ASRC=autoaudiosrc
#ASRC=pulsesrc

gst-launch-0.10 -e -v ximagesrc use-damage=$DAM show-pointer=$POINTER startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! queue ! video/x-raw-rgb,width=$OWIDTH,height=$OHEIGHT,framerate=30/1 ! videoscale ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! queue2 ! $ENC ! avimux name=mux ! filesink location=$VPATH/$TIME.$OFILE $ASRC ! queue ! audioconvert ! audiorate ! 'audio/x-raw-int,rate=48000,channels=2' ! mux.
