#!/bin/bash

#Script to capture a v4l2src to mkv file.

#set Encoder
ENC=jpegenc
#ENC=x264enc
#ENC=vp8enc
#ENC=avenc_mpeg2video
#set Muxer
MUX=matroskamux
#MUX=avimux
#MUX=mp4mux
#set v4l2 video device
#VDEVIN=/dev/video5

#set ximage capture area
STARTX=0
STARTY=0
ENDX=1279
ENDY=719

#show cursor?
POINTER=false
#use damaged?
DAM=0

#set output path and file
VPATH=~/Videos/capture
OFILE=ximagesrc-mjpeg-jack-convert.mkv
TIME=$(date "+%Y.%m.%d-%H.%M.%S")


#set Output Width/Height
WIDTH=1280
HEIGHT=720

#set your Audio Source
ASRC=jackaudiosrc
#ASRC=pulsesrc


gst-launch-1.0 -e -v $MUX name=mux ! filesink location=$VPATH/$TIME.$OFILE ximagesrc startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY use-damage=$DAM show-pointer=$POINTER ! videoconvert ! video/x-raw,format=I420 ! $ENC ! image/jpeg,width=1280,height=720,framerate=30/1 ! mux.video_0 $ASRC ! audioconvert ! queue ! audio/x-raw,format=S16LE ! mux.audio_0

