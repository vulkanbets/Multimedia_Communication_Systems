clc
clear all
close all

rgbImage = imread('Flooded_house.jpg', 'jpg');      % Load Image
ycbcr = rgb2ycbcr(rgbImage);                        % convert RGB to YCbCr
Y = ycbcr(:, :, 1);                                 % Y component only
Cr = ycbcr(:, :, 2);                                % Cr component only
Cb = ycbcr(:, :, 3);                                % Cb component only
% This is to assign a size to each row, column, and channels variables
[rows, columns, numberOfYcbcrChannels] = size(ycbcr);
% This is to assign a size to each row, column, and channels variables

sub_Cr = zeros( (rows/2), (columns/2), 'uint8' );   % fill subsampled array with 0's
sub_Cb = zeros( (rows/2), (columns/2), 'uint8' );   % fill subsampled array with 0's
up_Cr = zeros( (rows), (columns), 'uint8' );        % fill Upsampled array with 0's
up_Cb = zeros( (rows), (columns), 'uint8' );        % fill Upsampled array with 0's

x = 1;                                  % Rows
y = 1;                                  % Columns
for i = 1:2:rows
    for j = 1:2:columns
        sub_Cr(x, y) = Cr( ((x*2)-1), ((y*2)-1) );  % 4:2:0 subsampling
        sub_Cb(x, y) = Cb( ((x*2)-1), ((y*2)-1) );  % 4:2:0 subsampling
        y = y + 1;
    end
    x = x + 1;
    y = 1;
end


x = 1;                                  % Rows
y = 1;                                  % Columns
for i = 1:1:rows
    for j = 1:1:columns
        % Upsampling Linear Interpolation
        if( mod(i, 2) == 1 )                % Odd Row
            up_Cr(i, j) = sub_Cr(x, y);
            up_Cb(i, j) = sub_Cb(x, y);
        else                                % Even Row
            up_Cr(i, j) = up_Cr((i - 1), j);
            up_Cb(i, j) = up_Cb((i - 1), j);
        end
        if( mod(j, 2) == 0 ) y = y + 1; end
    end
    if( mod(i, 2) == 0 ) x = x + 1; end
    y = 1;
end

%  This is to display the Upsampled images
figure;                                                 % 
subplot(1, 2, 1);                                       % This code displays both the
imshow(up_Cr);                                          % 
title('Upsampled Cr Band using Row Replication');       % Cr and Cb Upsampled bands
subplot(1, 2, 2);                                       % 
imshow(up_Cb);                                          % In one figure
title('Upsampled Cb Band using Row Replication');       % 
% This is to display the Upsampled images


Folder = '.\';
File   = 'UpsampledCbRowReplicate.jpg';
Img    = up_Cr;
imwrite(Img, fullfile(Folder, File));

Folder = '.\';
File   = 'UpsampledCrRowReplicate.jpg';
Img    = up_Cb;
imwrite(Img, fullfile(Folder, File));



