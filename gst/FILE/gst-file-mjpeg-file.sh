#!/bin/bash

#Script to convert video files to mjpeg scaled framerate adjusted good for use in veejay

#set output path and file

VPATH=~/Videos/veejay
OFILE=veejay.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set the encoder
ENC=jpegenc

#set Output Width/Height and framerate
WIDTH=640
HEIGHT=480
FPS=30/1
#set uri (provide file name and path at command line usage: gst-file-264-file.sh file.avi)
URI=$1

gst-launch-0.10 avimux name=mux ! filesink  location=\"$VPATH/$TIME.$OFILE\" uridecodebin uri="$URI" name=demux demux. ! videoscale ! videorate ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! $ENC ! queue ! mux.video_0 demux. ! progressreport ! audioconvert ! audiorate ! audioresample ! 'audio/x-raw-int,rate=48000,cahannels=2'  ! queue ! mux.audio_0

#\"file:/home/hero/Videos/clips/soundlessdawn/The Vaporous Bridge to Stellar Window.flv\"

#! audiorate ! 'audio/x-raw-int,rate=48000,cahannels=2' 
