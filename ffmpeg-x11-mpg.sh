#!/bin/bash
#script to capture desktop to mpeg file 
#set path and file name
VPATH=~/Videos/capture
OFILE=x11-ffmpg.avi
TIME=$(date "+%Y.%m.%d-%H.%M.%S")


REZ=1024x768
ffmpeg -f alsa -ac 2 -i pulse -f x11grab -s $REZ -r 25 -i :0.0+0,0 -vcodec mpeg2video -ar 44100 -s $REZ -y -sameq $VPATH/$TIME.$OFILE

