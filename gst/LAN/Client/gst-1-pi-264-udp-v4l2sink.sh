gst-launch-1.0 -vvv udpsrc port=5001 ! application/x-rtp, payload=96 ! rtph264depay ! avdec_h264 ! videoconvert ! v4l2sink device=/dev/video7
#196ms
#183ms
#multicast-group=10.42.0.255  auto-multicast=true
