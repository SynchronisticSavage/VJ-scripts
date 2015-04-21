#!/bin/bash

#Script to capture desktop to mjpeg AVI file good for loading in veejay

#set Encoder

ENC=jpegenc
#ENC=x264enc

#set output path and file
VPATH=~/Videos/capture
OFILE=gst-v4l2src-jack-mjpg-gst1.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set v4l2src and resolution
VDEV=/dev/video5
OWIDTH=320
OHEIGHT=240
#show cursor?
POINTER=false
#use damaged?
DAM=0
#set Output Width/Height (scale)
WIDTH=320
HEIGHT=240

#set your Audio Source
ASRC=jackaudiosrc
#ASRC=autoaudiosrc
#ASRC=pulsesrc

gst-launch-1.0 -v -e v4l2src device=$VDEV do-timestamp=true ! queue ! avimux name=mux  ! filesink location=$VPATH/$TIME.$OFILE $ASRC ! queue ! audioconvert ! mux.
