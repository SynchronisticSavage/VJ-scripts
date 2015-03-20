#!/bin/bash

#Script to capture desktop to avi file playable in Veejay mjpegenc seems to work pretty good
#avenc_mjpeg also seems to work
#x264 enc seems to work but is not seekable
#still not working: avenc_yuv4 j2k jpegls asv2 avenc_huffyuv

#set Encoder
#ENC=avenc_yuv4
#ENC=jpegenc
#ENC=avenc_msmpeg4
#ENC=x264enc
#ENC=y4menc
#ENC=avenc_mpeg4
#ENC=avenc_msmpeg4v2
#ENC=avenc_msmpeg4
#ENC=avenc_mjpeg
#ENC=avenc_j2k
#ENC=avenc_jpegls
#ENC=avenc_asv2
#ENC=avenc_yuv4
#ENC=avenc_ljpeg
#ENC=avenc_huffyuv
#ENC=theoraenc
#ENC=avenc_mpeg2video
#set encoder options

#set encoder bitrate

BRATE=2500000
BIT=
#BIT=bitrate=$BRATE

#set Muxer
#MUX=avmux_avi
MUX=avimux
#MUX=qtmux
#set output path and file
VPATH=~/Videos/capture
OFILE=gst-ximg-jack-mpeg2.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set ximgsrc capture area and original resolution
STARTX=0
STARTY=0
ENDX=1279
ENDY=719
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
#ASRC=jackaudiosrc	
#ASRC=autoaudiosrc
ASRC=pulsesrc

gst-launch-1.0 -e -v ximagesrc use-damage=$DAM show-pointer=$POINTER startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! queue ! video/x-raw,width=$OWIDTH,height=$OHEIGHT,framerate=30/1 ! videoscale ! videoconvert ! queue ! $ENC $BIT ! $MUX name=mux ! filesink location=$VPATH/$TIME.$OFILE $ASRC ! queue2 ! audioconvert ! 'audio/x-raw,rate=44100,channels=2' ! mux.
