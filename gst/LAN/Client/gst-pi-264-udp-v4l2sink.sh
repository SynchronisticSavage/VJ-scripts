gst-launch -vvv udpsrc port=5001 ! application/x-rtp, payload=96 ! rtph264depay ! ffdec_h264 ! ffmpegcolorspace ! v4l2sink device=/dev/video7
#196ms
#183ms
