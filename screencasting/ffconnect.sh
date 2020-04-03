#! /bin/bash

INRES="1366x768"
FPS="2"

#OUTRES="1920x1079"
#QUAL="medium"
OUTRES="1366x768"
QUAL="fast"
# If you have low bandwidth, put the qual preset on 'fast' (upload bandwidth)
# If you have medium bandwitch put it on normal to medium

# ffmpeg \
#     -f x11grab -s $INRES -r "$FPS" -re -i :0.0 \
#     -c:v libvpx-vp9 \
#     http://localhost:8090/feed1.ffm

# ffmpeg \
#     -f x11grab -s $INRES -r "$FPS" -re -i :0.0 \
#     -c:v libx264 -pix_fmt yuv420p -preset ultrafast -g 20 -b:v 2500k -threads 0 -bufsize 256k \
#     http://localhost:8090/feed1.ffm

# ffmpeg \
#     -f x11grab -s $INRES -r "$FPS" -re -i :0.0 \
#     -c:v libx264 -trellis 0 -subq 1 -level 32 -preset superfast -me_method epzs -crf 30 -threads 0 -bufsize 1 -refs 4 -coder 0 -b_strategy 0 -bf 0 -sc_threshold 0 -x264-params vbv-maxrate=2000:slice-max-size=1500:keyint=30:min-keyint=10: -pix_fmt yuv420p -an \
#     http://localhost:8090/feed1.ffm



ffmpeg \
    -f x11grab -s $INRES -r "$FPS" -re -i :0.0 \
    -c:v libx264 -pix_fmt yuv420p -preset ultrafast -g 20 -b:v 2500k -threads 0 -bufsize 256k \
    http://localhost:8090/feed1.ffm

# ffmpeg -f v4l2 -s 640x480 -r 15 -i /dev/video0 -vcodec libx265 -threads 2 -tune zerolatency http://localhost:8090/feed1.ffm

#    -vcodec libx264 -s $OUTRES -preset $QUAL \
#    -acodec aac -ar 44100 -b:a 128k -bufsize 512k \

# ffmpeg -video_size 1366x768 -framerate 10 \
#     -f x11grab -i :0.0 -vf scale=1366x768 -an -fflags nobuffer \
# -c:v libx264 -pix_fmt yuv420p -preset ultrafast -g 20 -b:v 2500k -threads 0 -bufsize 256k \
#     -f mpegts http://localhost:8090/feed1.ffm

# ffmpeg -f v4l2 -input_format yuyv422 -s 640x480 -i /dev/video0 \
#     -c:v libx264 -profile:v baseline -trellis 0 -subq 1 -level 32 -preset superfast -tune zerolatency -me_method epzs -crf 30 -threads 0 -bufsize 1 -refs 4 -coder 0 -b_strategy 0 -bf 0 -sc_threshold 0 -x264-params vbv-maxrate=2000:slice-max-size=1500:keyint=30:min-keyint=10: -pix_fmt yuv420p -an \
#     -f mpegts udp://192.168.1.8:5001
