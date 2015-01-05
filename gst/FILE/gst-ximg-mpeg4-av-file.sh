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

gst-launch-0.10 avimux name=mux ! filesink location=test0.avi v4l2src device=/dev/video2 ! \
video/x-raw-yuv,width=640,height=480,framerate=\(fraction\)30000/1001 ! ffmpegcolorspace ! \ 
ffenc_mpeg4 ! queue ! mux. alsasrc device=hw:2,0 ! audio/x-raw-int,channels=2,rate=32000,depth=16 ! \ 
audioconvert ! lame ! mux.
