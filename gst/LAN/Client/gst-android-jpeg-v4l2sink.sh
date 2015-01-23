#!/bin/bash
ODEV=/dev/video3

gst-launch souphttpsrc location="http://192.168.0.125:8080/videofeed" ! jpegdec ! v4l2sink device=$ODEV
