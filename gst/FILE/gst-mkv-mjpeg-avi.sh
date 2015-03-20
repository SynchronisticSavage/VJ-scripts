#!/bin/bash

#Script to convert video files to mjpeg scaled framerate adjusted good for use in veejay

#set output path and file

VPATH=~/Videos/veejay
OFILE=avi-from-mkv.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set the encoder
ENC=jpegenc

#set Output Width/Height and framerate
WIDTH=640
HEIGHT=480
FPS=30/1
#set uri (provide file name and path at command line usage: gst-file-264-file.sh file.avi)
URI=$1
LOC="/home/hero/Videos/capture/2015.03.12-22.58.54.v4l2src-mjpeg-jack.mkv"
#gst-launch-0.10 -v filesrc location=$LOC ! matroskademux
#gst-launch-1.0 -v filesrc location=$LOC ! matroskademux name=d d.video_00 ! queue ! m. d.audio_00 ! queue ! m. avimux name=m ! filesink location=out4.avi

#gst-launch-0.10 -v avimux name=mux ! filesink location=out3.avi filesrc location=$LOC ! matroskademux name=d ! audio/x-raw-int ! queue ! mux. d. ! queue ! mux.

#gst-launch-0.10 filesrc location=$LOC ! matroskademux ! avimux ! filesink location=out2.avi

gst-launch-0.10 -m -v -T filesrc location=$LOC ! matroskademux name=d  d.audio_00 ! queue ! m.audio_00  d.video_00 ! queue  ! m.video_00 avimux name=m !  filesink location=out5.avi

#gst-launch-0.10 avimux name=mux ! filesink  location=\"$VPATH/$TIME.$OFILE\" uridecodebin uri="$URI" name=demux demux. ! videoscale ! videorate ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! $ENC ! queue ! mux.video_0 demux. ! progressreport ! audioconvert ! audiorate ! audioresample ! 'audio/x-raw-int,rate=48000,cahannels=2' ! queue ! mux.audio_0

#\"file:/home/hero/Videos/clips/soundlessdawn/The Vaporous Bridge to Stellar Window.flv\"

#! audiorate ! 'audio/x-raw-int,rate=48000,cahannels=2' 
