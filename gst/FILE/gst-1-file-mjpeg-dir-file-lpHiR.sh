#!/bin/bash

#Script to convert video files to mjpeg scaled framerate adjusted good for use in veejay
#set input path or grab from the terminal: usage ./gst-file-mjpeg-file-lpHiR.sh /path/to/inputfile /path/to/outputfile
IFILE=$1
#set output Dir and make if it does not exsist
VPATH=~/Videos/lpHiR
mkdir -p $VPATH &&
#set output filename from input file via stripped file path and extension
SFILE=$(/usr/bin/basename "$IFILE")
NFILE=${SFILE%.*}
#output to chosen vpath and filename
OFILE=$VPATH/$NFILE.lpHiR.avi

#or just get from the command line
#OFILE=$2

#TIME=$(date "+%Y.%m.%d-%H.%M.%S")   

#set the encoder
ENC=jpegenc

#set Output Width/Height and framerate
WIDTH=640
HEIGHT=480
FPS=30/1
  echo "Converting $IFILE to lpHiR friendly $OFILE :)" 
# run the script
gst-launch-1.0 avimux name=mux ! filesink  location=$OFILE uridecodebin uri="file:$IFILE" name=demux demux. ! videoscale ! videorate ! videoconvert ! video/x-raw,format=I420,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! $ENC ! queue ! mux.video_0 demux. ! progressreport ! audioconvert ! audiorate ! audioresample quality=10 ! 'audio/x-raw,rate=48000,cahannels=2'  ! queue ! mux.audio_0




