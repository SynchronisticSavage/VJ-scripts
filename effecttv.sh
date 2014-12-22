#!/bin/bash
#script to run effectv  in ubuntu 12.04 64bit

#set cam input resolution
IREZ=640x480

#set window output resolution
OREZ=1024x768

export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libv4l/v4l1compat.so" effectv

effectv -device /dev/video1 -size $IREZ -geometry $OREZ 

