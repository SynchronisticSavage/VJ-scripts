#!/bin/bash

#Script to capture desktop to avi file playable in Veejay

#set Encoder

ENC=jpegenc
#ENC=x264enc

#set output path and file
VPATH=~/Videos/capture
OFILE=gst-v4l2src-jack-qt.mov
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set v4l2src and resolution
VDEV=/dev/video5
OWIDTH=1280
OHEIGHT=720
#show cursor?
POINTER=false
#use damaged?
DAM=0
#set Output Width/Height (scale)
WIDTH=1280
HEIGHT=720

#set your Audio Source
ASRC=jackaudiosrc
#ASRC=autoaudiosrc
#ASRC=pulsesrc

#gst-launch-1.0 -v -e v4l2src device=$VDEV do-timestamp=true ! queue ! avimux name=mux  ! filesink location=$VPATH/$TIME.$OFILE $ASRC ! queue ! audioconvert ! mux.


gst-launch-1.0 v4l2src device=$VDEV ! video/x-raw,width=$WIDTH,height=$HEIGHT ! videoconvert ! qtmux ! filesink location=$VPATH/$TIME.$OFILE
