#!/bin/bash

#Script to capture a v4l2src to avi file playable in Veejay

#set Encoder
ENC=jpegenc
#ENC=x264enc

#set v4l2 video device
VDEVIN=/dev/video5

#set output path and file
VPATH=~/Videos/capture
OFILE=v4l2src-mjpeg-pulse.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")


#set Output Width/Height
WIDTH=320
HEIGHT=240
FPS=125
#set your Audio Source
ASRC=jackaudiosrc
#ASRC=pulsesrc

#TODO Tee to V4l2loopback

gst-launch-0.10 -e -v v4l2src device=$VDEVIN ! videoscale ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FPS/1 ! $ENC ! queue ! avimux name=mux ! filesink location=$VPATH/$TIME.$OFILE $ASRC  ! audioconvert ! 'audio/x-raw-int,rate=48000,cahannels=2' ! mux.

