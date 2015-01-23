#!/bin/bash

#Script to convert video files to mjpeg scaled framerate adjusted good for use in veejay
#set input path
FILES=/home/hero/Videos/lphir/test-reel/*
#set output Dir and make if it does not exsist
VPATH=~/Videos/web/lphir/test-reel
mkdir -p $VPATH &&

for f in $FILES
do
Z="$f"
echo " zed yo $Z"

#set output path and file
SFILE=$(/usr/bin/basename "$f")
echo "sfile yo: $SFILE"
NOEXT=${SFILE%.*}
echo "NoeXt YO!!: $NOEXT"

OFILE=\"$VPATH/$NOEXT-veejay.avi\"

#TIME=$(date "+%Y.%m.%d-%H.%M.%S")   

#set the encoder
ENC=x264enc

#set Output Width/Height and framerate
WIDTH=1024
HEIGHT=768
FPS=30/1
  echo "converting $Z  to $OFILE" 
# run the script
/usr/bin/gst-launch avimux name=mux ! filesink  location=$OFILE uridecodebin uri="file:$Z" name=demux demux. ! videoscale ! videorate ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! $ENC ! queue ! mux.video_0 demux. ! progressreport ! audioconvert ! lame ! queue ! mux.audio_0

done

