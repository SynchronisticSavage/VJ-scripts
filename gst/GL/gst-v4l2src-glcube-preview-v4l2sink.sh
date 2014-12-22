#! /bin/bash
#script to pipe v4l2src through GL effects and cube to a v4l2loopback device and a xv preview window 
EFFECT=2
EFFECT2=4
EFFECT3=15
EFFECTV=vertigotv
SRC=/dev/video1
SINK=/dev/video2
gst-launch v4l2src device=$SRC ! video/x-raw-yuv,width=640,height=480,framerate=30/1 ! ffmpegcolorspace ! $EFFECTV ! glupload ! gleffects effect=$EFFECT3 ! glfiltercube ! gleffects effect=$EFFECT ! gleffects effect=$EFFECT2 ! gldownload ! video/x-raw-yuv,width=640,height=480 ! tee name=t ! queue ! v4l2sink device=$SINK t. ! queue ! xvimagesink t.

