#!/bin/bash
#script to capture desktop to mpeg file 
#set path and file name
VPATH=~/Videos/capture
OFILE=x11-lphir-ffmpg.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")


#set the video codec
CODEC=mjpeg
#CODEC=mpeg2video -sameq
#set the resolution and framerate
FPS=30
REZ=640x480
#ffmpeg -f alsa -ac 2 -i pulse -f x11grab -s $REZ -r $FPS -i :0.0+0,0 -vcodec $CODEC -ar 48000 -s $REZ -y -qscale 1 -an -sameq $VPATH/$TIME.$OFILE
ffmpeg -f jack -ac 2 -i ffmpeg -f v4l2 -s $REZ -r $FPS -i /dev/video5 -vcodec $CODEC -acodec pcm_s16le -ar 48000 -s $REZ -y -qscale 1 -sameq $VPATH/$TIME.$OFILE

