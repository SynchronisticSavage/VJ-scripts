#!/bin/bash
gst-launch souphttpsrc location="http://10.42.0.123:8080/videofeed" ! jpegdec ! xvimagesink
