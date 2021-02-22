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
up_Cr2 = zeros( (rows), (columns), 'uint8' );       % fill Upsampled array with 0's
up_Cb2 = zeros( (rows), (columns), 'uint8' );       % fill Upsampled array with 0's


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

%  Linear Interpolation
x = 1;                                  % Rows
y = 1;                                  % Columns
for i = 1:1:rows
    for j = 1:1:columns
        % Upsampling Linear Interpolation
        if( mod(i, 2) == 1 )                % Odd Row
            if( mod(j, 2) == 1 )            % Odd Row Odd Column
                up_Cr(i, j) = sub_Cr(x, y);
                up_Cb(i, j) = sub_Cb(x, y);
            else                            % Odd Row Even Column
                if(j == columns)
                    up_Cr(i, j) = sub_Cr(x, y);     % Last column of pixels (edge case)
                    up_Cb(i, j) = sub_Cb(x, y);     % Last column of pixels (edge case)
                else
                    up_Cr(i, j) = (sub_Cr(x, y))/2 + (sub_Cr(x, y+1))/2;    % average of left and right pixels
                    up_Cb(i, j) = (sub_Cb(x, y))/2 + (sub_Cb(x, y+1))/2;    % average of left and right pixels
                end
            end
        else                                            % Even Row
            if(i == rows)
                up_Cr(i, j) = sub_Cr(x, y);               % Last row of pixels (edge case)
                up_Cb(i, j) = sub_Cb(x, y);               % Last row of pixels (edge case)
            else                                            % 
                up_Cr(i, j) = (sub_Cr(x, y))/2 + sub_Cr(x+1, y)/2;      % average of pixels above and below
                up_Cb(i, j) = (sub_Cb(x, y))/2 + sub_Cb(x+1, y)/2;      % average of pixels above and below
            end
        end
        if( mod(j, 2) == 0 ) y = y + 1; end
    end
    if( mod(i, 2) == 0 ) x = x + 1; end
    y = 1;
end             % Linear Interpolation


% Row Replication
x = 1;                                  % Rows
y = 1;                                  % Columns
for i = 1:1:rows
    for j = 1:1:columns
        % Upsampling Linear Interpolation
        if( mod(i, 2) == 1 )                % Odd Row
            up_Cr2(i, j) = sub_Cr(x, y);
            up_Cb2(i, j) = sub_Cb(x, y);
        else                                % Even Row
            up_Cr2(i, j) = up_Cr2((i - 1), j);
            up_Cb2(i, j) = up_Cb2((i - 1), j);
        end
        if( mod(j, 2) == 0 ) y = y + 1; end
    end
    if( mod(i, 2) == 0 ) x = x + 1; end
    y = 1;
end                     % Row replication

interRgbImage = cat(3, Y, up_Cr, up_Cb);        % This converts 
interRgbImage = ycbcr2rgb(interRgbImage);       % both Upsampled YCbCr
repliRgbImage = cat(3, Y, up_Cr2, up_Cb2);      % images back to rgb
repliRgbImage = ycbcr2rgb(repliRgbImage);       % Format

%  This is to display the Upsampled images
figure;                                                                         % 
subplot(1, 2, 1);                                                               % This code displays both the
imshow(interRgbImage);                                                          % 
title('Upsampled image using Interpolation and converted back to RGB:');        % Cr and Cb Upsampled bands
subplot(1, 2, 2);                                                               % 
imshow(repliRgbImage);                                                          % In one figure
title('Upsampled image using Col Replication and converted back to RGB:');      % 
% This is to display the Upsampled images


% Find Mean Squared Error between original rgb image and interpolated image
err = immse(interRgbImage, rgbImage);
fprintf('\n The mean-squared error is %0.4f\n', err);


