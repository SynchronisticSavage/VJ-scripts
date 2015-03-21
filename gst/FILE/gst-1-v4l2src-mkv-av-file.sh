#!/bin/bash

#Script to capture a v4l2src to mkv file. (good for long, clean, synced av)

#set Encoder
ENC=jpegenc
#ENC=x264enc

#set Muxer
MUX=matroskamux
#MUX=avimux

#set v4l2 video device
VDEVIN=/dev/video5

#set output path and file
VPATH=~/Videos/capture
OFILE=v4l2src-mjpeg-jack-gst1.mkv
TIME=$(date "+%Y.%m.%d-%H.%M.%S")


#set Output Width/Height
WIDTH=1280
HEIGHT=720

#set your Audio Source
ASRC=jackaudiosrc
#ASRC=pulsesrc

gst-launch-1.0 -e -v $MUX name=mux ! filesink location=$VPATH/$TIME.$OFILE v4l2src device=$VDEVIN ! jpegenc ! image/jpeg,width=1280,height=720,framerate=30/1 ! mux.video_0 jackaudiosrc ! audioconvert ! queue ! audio/x-raw,format=S16LE ! mux.audio_0

#TODO Tee to V4l2loopback

#gst-launch-0.10 -e -v v4l2src device=$VDEVIN ! videoscale ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! $ENC ! queue ! avimux name=mux ! filesink location=$VPATH/$TIME.$OFILE $ASRC  ! audioconvert ! 'audio/x-raw-int,rate=48000,cahannels=2' ! mux.


#gst-launch -e -v matroskamux name=mux ! filesink location=$VPATH/$TIME.$OFILE v4l2src device=$VDEVIN ! mux.video_0 jackaudiosrc ! audioconvert ! queue ! mux.audio_0
