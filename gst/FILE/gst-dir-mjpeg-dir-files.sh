#!/bin/bash
#Script to convert video files to mjpeg scaled framerate adjusted good for use in veejay and lpHiR

#set input path
if [[ -n "$1" ]]; then
FILES=$1
echo "obtaining files from $FILES"
else
FILES=~/Videos/capture/tmp/*.mkv
echo "input file path set to $FILES"
fi

#set output Dir
if [[ -n "$2" ]];
then
VPATH=$2
echo "placing output files neatly in $VPATH"
else
VPATH=~/HiR/lpHiR/320x240/converted
echo "smoothly dropping output files in $VPATH"
fi

#create output directory if it does not exsist
mkdir -p $VPATH &&

#run loop of files
for f in $FILES
do

#set output path and filename
SFILE=$(/usr/bin/basename "$f")
NOEXT=${SFILE%.*}
OFILE=\"$VPATH/$NOEXT-veejay.avi\"

#TIME=$(date "+%Y.%m.%d-%H.%M.%S")   

#set the encoder
ENC=jpegenc

#set Output Width/Height and framerate and audiorate
WIDTH=320
HEIGHT=240
FPS=125
FRAMERATE=$FPS/1
RATE=48000
echo "using $ENC to encode $NOEXT with a resolution of $WIDTH x $HEIGHT at $FPS frames per second"
echo "audio sample rate set to $RATE"

#set borders to maintain aspect ratio?
BORDERS=true
echo "setting maintain aspect ratio to: $BORDERS"

  echo "Recombobulating $f to $OFILE" 
# run the script
/usr/bin/gst-launch avimux name=mux ! filesink  location=$OFILE uridecodebin uri="file:$f" name=demux demux. ! videoscale add-borders=$BORDERS ! videorate ! ffmpegcolorspace ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT,framerate=$FRAMERATE ! $ENC ! queue ! mux.video_0 demux. ! progressreport ! audioconvert ! audioresample quality=10 ! audio/x-raw-int,rate=$RATE,channels=2  ! queue ! mux.audio_0

done


