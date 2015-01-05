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
ENDX=1023
ENDY=767
OWIDTH=1024
OHEIGHT=768
#show cursor?
POINTER=false
DAM=0
#set Output Width/Height (scale)
WIDTH=1024
HEIGHT=768

#set your Audio Source
ASRC=jackaudiosrc
#ASRC=autoaudiosrc
#ASRC=pulsesrc

gst-launch -e ximagesrc use-damage=$DAM show-pointer=$POINTER startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! $ENC ! queue ! mux. $ASRC  connect=2 ! audioconvert ! 'audio/x-raw-int,rate=48000,channels=2' ! queue ! mux. avimux name=mux ! filesink location=$VPATH/$TIME.$OFILE
