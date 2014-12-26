#script to launch veejay and reloaded

#set capture area
STARTX=0
STARTY=0
ENDX=1023
ENDY=767

#show cursor?
POINTER=false

#set output resolution and framerate (scale)
WIDTH=640
HEIGHT=480
FPS=30/1

#set audio rate
ARATE=48000

#set veejay output v4l2loopback device
ODEV=/dev/video7

#load v4l2loopback kernel module (comment if you set it to load on startup)
sudo modprobe v4l2loopback devices=8
#make first in first out file
mkfifo /tmp/pipe

#pipe desktop to v4l2loopback device
gst-launch -v ximagesrc use-damage=0 show-pointer=false startx=$STARTX starty=$STARTY endx=$ENDX endy=$ENDY ! ffmpegcolorspace ! videoscale ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FPS ! v4l2sink device=/dev/video4 &

#pipe /tmp/pipe to output Veejay to /dev/video3
yuv4mpeg_to_v4l2 $ODEV < /tmp/pipe &

#start VeeJay Server with options to output 640x480 to ODEV via /tmp/pipe
veejay --audiorate $ARATE --fps $FPS --verbose --output 4 --output-file /tmp/pipe -w $WIDTH -h $HEIGHT -W $WIDTH -H $HEIGHT -N 1 &

#start reloaded VJ Client

reloaded


