#!/bin/bash

#Script to capture a v4l2src to mkv file.

#set Encoder
ENC=jpegenc
#ENC=x264enc

#set Muxer
MUX=matroskamux
#MUX=avimux

#set v4l2 video device
#VDEVIN=/dev/video5

#set ximage capture area
STARTX=0
STARTY=0
ENDX=1279
ENDY=719
POINTER=false
#set output path and file
VPATH=~/Videos/capture
OFILE=ximgsrc-mjpeg-jack.mkv
TIME=$(date "+%Y.%m.%d-%H.%M.%S")


#set Output Width/Height
WIDTH=1280
HEIGHT=720

#set your Audio Source
ASRC=jackaudiosrc
#ASRC=pulsesrc


gst-launch-1.0 -e -v $MUX name=mux ! filesink location=$VPATH/$TIME.$OFILE ximagesrc startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY show-pointer=$POINTER ! jpegenc ! image/jpeg,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! mux.video_0 jackaudiosrc ! audioconvert ! queue ! audio/x-raw,format=S16LE ! mux.audio_0

