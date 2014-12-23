#!/bin/bash
#script to convert video files to vp8 pass input file from command line
#needs testing, computer locked up twice running this script
#set output file name
VPATH=~/Videos/web
OFILE=vp8.webm
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set encoder
ENC=vp8enc

#set uri (provide file name and path at command line usage: gst-file-264-file.sh file.avi)
URI=file://$1

gst-launch-0.10 webmmux name=mux ! filesink location=\"$VPATH/$TIME.$OFILE\" uridecodebin uri=$URI name=demux demux. ! $ENC ! queue ! mux.video_0 demux. ! progressreport ! audioconvert ! audioresample ! vorbisenc ! queue ! mux.audio_0

#gst-launch-0.10 filesrc location=oldfile.ext ! decodebin name=demux ! queue ! ffmpegcolorspace ! vp8enc ! webmmux name=mux ! filesink location=newfile.webm demux. ! queue ! progressreport ! audioconvert ! audioresample ! vorbisenc ! mux

#gst-launch-0.10 -v filesrc location=$1 ! decodebin2 name=demux ! queue ! ffmpegcolorspace ! vp8enc ! webmmux name=mux ! filesink location=$VPATH/$TIME.$OFILE demux. ! queue ! progressreport ! audioconvert ! audioresample ! vorbisenc ! mux.
