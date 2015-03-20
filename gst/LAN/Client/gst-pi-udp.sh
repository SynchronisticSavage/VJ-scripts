gst-launch -v udpsrc port=5001 ! application/x-rtp, payload=96 ! rtph264depay ! ffdec_h264 ! ffmpegcolorspace ! xvimagesink
#196ms
#183ms
