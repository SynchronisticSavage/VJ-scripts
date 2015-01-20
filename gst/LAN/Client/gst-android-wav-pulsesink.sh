#!/bin/bash
IP=10.42.0.123
PORT=8080
TIMESTAMP=false
gst-launch souphttpsrc location="http://$IP:$PORT/audio.wav" do-timestamp=$TIMESTAMP is-live=true ! wavparse ! audioconvert ! volume volume=3 ! rglimiter ! pulsesink sync=false
