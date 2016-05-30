gst-launch-1.0 -vvv udpsrc  port=5001  ! application/x-rtp, payload=96 ! rtph264depay ! h264parse ! vaapidecode ! vaapisink
#gst-launch-1.0 -vvv udpsrc  port=5001  ! application/x-rtp, payload=96 ! rtph264depay ! avdec_h264 ! videoconvert ! xvimagesink
#196ms
#183ms
#multicast-group=10.42.0.255 auto-multicast=true
