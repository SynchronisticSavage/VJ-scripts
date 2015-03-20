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
WIDTH=1280
HEIGHT=720

#set your Audio Source
ASRC=jackaudiosrc
#ASRC=pulsesrc

#TODO Tee to V4l2loopback

#gst-launch-0.10 -e -v v4l2src device=$VDEVIN ! videoscale ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! $ENC ! queue ! avimux name=mux ! filesink location=$VPATH/$TIME.$OFILE $ASRC  ! audioconvert ! 'audio/x-raw-int,rate=48000,cahannels=2' ! mux.


gst-launch -e -v avimux name=mux ! filesink location=$VPATH/$TIME.$OFILE v4l2src device=$VDEVIN ! mux.video_0 jackaudiosrc ! audioconvert ! queue2 ! mux.audio_0

