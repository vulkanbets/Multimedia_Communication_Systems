clc
clear all
close all

rgbImage = imread('Flooded_house.jpg', 'jpg');  % 
figure(1);                                      % Original R_G_B
subplot(2,2,1);                                 % Image with plot
imshow(rgbImage);                               % 
title('Original RGB Image');                    % 

% This is to assign a size to each to row, column, and channels variables
[rows, columns, numberOfColorChannels] = size(rgbImage);
% This is to assign a size to each to row, column, and channels variables

red = rgbImage(:,:,1);                      % assign red components to red variable
green = rgbImage(:,:,2);                    % assign green components to green variable
blue = rgbImage(:,:,3);                     % assign blue components to blue variable
black = zeros(rows, columns, 'uint8');      % assign black components to black variable

Red_band = cat(3, red, black, black);       % This concatinates only the
subplot(2, 2, 2);                           % red pixels and leaves the
imshow(Red_band);                           % other components black
title('Red Band');                          % Plot and show the Red Band

Green_band = cat(3, black, green, black);   % This concatinates only the
subplot(2, 2, 3);                           % green pixels and leaves the
imshow(Green_band);                         % other components black
title('Green Band');                        % Plot and show the Red Band

Blue_band = cat(3, black, black, blue);     % This concatinates only the
subplot(2, 2, 4);                           % blue pixels and leaves the
imshow(Blue_band);                          % other components black
title('Blue Band');                         % Plot and show the Red Band
