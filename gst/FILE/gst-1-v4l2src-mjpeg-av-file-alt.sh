#!/bin/bash

#Script to capture desktop to avi file playable in Veejay

#set Encoder

ENC=jpegenc
#ENC=x264enc

#set output path and file
VPATH=~/Videos/capture
OFILE=gst-v4l2src-7-jack-mjpg-alt.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set v4l2src and resolution
VDEV=/dev/video7
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
#ASRC=alsasrc
ASRC=jackaudiosrc
#ASRC=autoaudiosrc
#ASRC=pulsesrc

#gst-launch-1.0 -v -e v4l2src device=$VDEV ! $ENC ! queue2 ! avimux name=mux  ! filesink location=$VPATH/$TIME.$OFILE $ASRC do-timestamp=true ! audioconvert ! mux.
#'audio/x-raw,format=(string)S16LE,rate=(int)48000,channels=(int)2' ! audiorate ! audioresample ! 'audio/x-raw,rate=(int)44100' ! audioconvert ! 'audio/x-raw,channels=(int)1'

gst-launch-1.0 -v avimux name=mux v4l2src device=$VDEV do-timestamp=true ! video/x-raw,width=$OWIDTH,height=$OHEIGHT ! videoconvert ! video/x-raw,width=$WIDTH,height=$HEIGHT ! jpegenc  ! queue ! mux. $ASRC ! queue ! mux. mux. ! filesink location=$VPATH/$TIME.$OFILE

