#!/bin/bash
#script to stream a v4l2 capture device onto a cube, add an effect and output to a gl window

#set the capture device
IDEV=/dev/video0

#set the gl window resolution
WIDTH=1024
HEIGHT=768

#set the effect, try different numbers (0-15) for different effects
EFFECT=7
gst-launch v4l2src device=$IDEV ! glupload ! glfiltercube ! gleffects effect=$EFFECT ! video/x-raw-gl,width=$WIDTH,height=$HEIGHT ! glimagesink

