#!/bin/bash
#script to stream youtube video to veejay compatable file

#set Video ID Get from youtube video url after watch?v= or the whole url
#VID=https://www.youtube.com/watch?v=-_qMagfZtv8

#or just grab it from the comand line
VID=$1

#set encoder
ENC=jpegenc

VNAME=$(/usr/bin/youtube-dl --get-title $VID)
#VNAME=$(/usr/bin/youtube-dl --get-filename $VID)
VPATH=~/Videos/capture
OFILE=$VNAME.youtube.avi
#OFILE=youtube.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

URI=$(/usr/bin/youtube-dl -g -f 18 $VID)

#set Output Width/Height (scale)
WIDTH=640
HEIGHT=480

gst-launch-0.10 avimux name=mux ! filesink location=\"$VPATH/$TIME.$OFILE\" uridecodebin uri=$URI name=demux demux. ! videoscale ! ffmpegcolorspace ! videorate ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=30/1 ! jpegenc ! queue ! mux.video_0 demux. ! progressreport ! audioconvert ! audiorate ! audioresample ! 'audio/x-raw-int,rate=48000,channels=2' ! queue ! mux.audio_0

