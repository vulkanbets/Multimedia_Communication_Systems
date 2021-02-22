clc
clear all
close all

rgbImage = imread('Flooded_house.jpg', 'jpg');
imshow(rgbImage);
title('Original RGB Image');


Folder = '.\';
File   = 'Original RGB Image.jpg';
Img    = rgbImage;
imwrite(Img, fullfile(Folder, File));

