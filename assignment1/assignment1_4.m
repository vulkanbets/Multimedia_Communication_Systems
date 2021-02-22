clc
clear all
close all

rgbImage = imread('Flooded_house.jpg', 'jpg');      % Load Image
ycbcr = rgb2ycbcr(rgbImage);                        % convert RGB to YCbCr

Y = ycbcr(:, :, 1);             % Y component only
Cr = ycbcr(:, :, 2);            % Cr component only
Cb = ycbcr(:, :, 3);            % Cb component only

figure;
subplot(2, 2, 1);
imshow(rgbImage);
title('RGB Image');
subplot(2, 2, 2);
imshow(Y);
title('Luminance (Y) Component');
subplot(2, 2, 3);
imshow(Cb);
title('Cb Component');
subplot(2, 2, 4);
imshow(Cr);
title('Cr Component');
