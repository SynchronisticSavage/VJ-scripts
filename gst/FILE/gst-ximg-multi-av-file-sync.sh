#!/bin/bash

#Script to capture desktop to avi file playable in Veejay

#set Encoder

ENC=jpegenc
#ENC=x264enc
#ENC=xvidenc

#set output path and file
VPATH=~/Videos/capture
OFILE=gst-ximg-jack-jpegenc.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set ximgsrc capture area and original resolution
STARTX=0
STARTY=0
ENDX=1279
ENDY=719
OWIDTH=1280
OHEIGHT=720
#show cursor?
POINTER=false
#use damaged?
DAM=0
#do timestamp?
TIMESTAMP=false

#set Output Width/Height (scale)
WIDTH=1280
HEIGHT=720

#set your Audio Source
ASRC=jackaudiosrc
#ASRC=autoaudiosrc
#ASRC=pulsesrc

gst-launch-0.10 -e -v ximagesrc do-timestamp=$TIMESTAMP use-damage=$DAM show-pointer=$POINTER startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! queue ! queue ! video/x-raw-rgb,width=$OWIDTH,height=$OHEIGHT,framerate=30/1 ! videoscale ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! queue ! $ENC ! avimux name=mux ! filesink location=$VPATH/$TIME.$OFILE $ASRC ! queue ! audioconvert ! 'audio/x-raw-int,rate=44100,channels=2' ! mux.
