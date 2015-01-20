#!/bin/bash
ODEV=/dev/video2

gst-launch souphttpsrc location="http://10.42.0.123:8080/videofeed" ! jpegdec ! v4l2sink device=$ODEV
