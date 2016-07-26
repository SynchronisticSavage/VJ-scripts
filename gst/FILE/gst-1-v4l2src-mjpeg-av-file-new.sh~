#!/bin/bash

#Script to capture desktop to avi file playable in Veejay

#set Encoder

#ENC=jpegenc
ENC=avenc_yuv4
#ENC=x264enc

#set output path and file
VPATH=~/Videos/capture
mkdir -p $VPATH
OFILE=test-av-gst-v4l2src-jack-mjpg.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set v4l2src and resolution
VDEV=/dev/video5
OWIDTH=640
OHEIGHT=480
#show cursor?
POINTER=false
#use damaged?
DAM=0
#set Output Width/Height (scale)
WIDTH=640
HEIGHT=480

#set your Audio Source
#ASRC=jackaudiosrc
#ASRC=autoaudiosrc
ASRC=pulsesrc

gst-launch-1.0 -v -e v4l2src device=$VDEV do-timestamp=true ! queue ! avimux name=mux  ! filesink location=$VPATH/$TIME.$OFILE $ASRC ! queue ! audioconvert ! mux.
