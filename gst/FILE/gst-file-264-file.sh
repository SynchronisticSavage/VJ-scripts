#!/bin/bash

#Script to convert video files to to a nice and compressed 264 avi file for uploading to the web

#set output path and file

#set the encoder
ENC=x264enc

VPATH=~/Videos/web
OFILE=x264.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")

#set uri (provide file name and path at command line usage: gst-file-264-file.sh file.avi)
URI=file://$1

gst-launch-0.10 avimux name=mux ! filesink location=\"$VPATH/$TIME.$OFILE\" uridecodebin uri=$URI name=demux demux. ! $ENC ! queue ! mux.video_0 demux. ! progressreport ! audioconvert ! lame ! queue ! mux.audio_0

