#!/bin/bash

#Script to convert video files to mjpeg scaled framerate adjusted good for use in veejay
#set path for files
PATH=/home/hero/Videos/Music*Videos
FILES=/home/hero/Videos/Music*Videos/*
for f in $FILES
do
Z=\"file:/$f\"
echo " zed yo $Z"
#set output path and file
VPATH=~/Videos/veejay/MusVid
SFILE=$(/usr/bin/basename "$f")
echo "sfile yo: $SFILE"
NOEXT=${SFILE%.*}
echo "NoeXt YO!!: $NOEXT"
#CFILE=${$SFILE %.*}
OFILE=\"$VPATH/$NOEXT-veejay.avi\"
#OFILE=veejay.avi

#TIME=$(date "+%Y.%m.%d-%H.%M.%S")   

#set the encoder
ENC=jpegenc

#set Output Width/Height and framerate
WIDTH=640
HEIGHT=480
FPS=30/1
#set uri (provide file name and path at command line usage: gst-file-264-file.sh file.avi)
URI=$f
  echo "converting $Z  to $OFILE" 
  # take action on each file. $f store current file name

done

