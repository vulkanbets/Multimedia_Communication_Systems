clc
clear all
close all

video_frames = VideoReader('walk_qcif.avi');
frame6 = read(video_frames, 6);
imshow(frame6);





















