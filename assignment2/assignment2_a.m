clc
clear all
close all

rgbImage = imread('Flooded_house.jpg', 'jpg');      % Load Image
ycbcr = rgb2ycbcr(rgbImage);                        % convert RGB to YCbCr
Y = ycbcr(:, :, 1);                                 % Y component only
Cr = ycbcr(:, :, 2);                                % Cr component only
Cb = ycbcr(:, :, 3);                                % Cb component only
% This is to assign a size to each to row, column, and channels variables
[rows, columns, numberOfYcbcrChannels] = size(ycbcr);
% This is to assign a size to each to row, column, and channels variables

sub_Cr = zeros( (rows/2), (columns/2), 'uint8' );        % fill subsampled array with 0's
sub_Cb = zeros( (rows/2), (columns/2), 'uint8' );        % fill subsampled array with 0's

x = 1;                                                   % Rows
y = 1;                                                   % Columns
for i = 1:2:rows
    for j = 1:2:columns
        sub_Cr(x, y) = Cr( ((x*2)-1), ((y*2)-1) );  % 4:2:0 subsampling
        sub_Cb(x, y) = Cb( ((x*2)-1), ((y*2)-1) );  % 4:2:0 subsampling
        y = y + 1;
    end
    x = x + 1;
    y = 1;
end



%  Encoder
%  Compute the 8x8 block DCT transform coefficients of the luminance and
%  chrominance components of the image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Prepare (normalize) all the matrices for transformation
y_norm = int16(Y);                  % Normalize Y and subtract
y_norm = y_norm - 128;              % 128 from all values in matrix
sub_cr_norm = int16(sub_Cr);        % Normalize sub-sampled Cr and subtract
sub_cr_norm = sub_cr_norm - 128;    % 128 from all values in matrix
sub_cb_norm = int16(sub_Cb);        % Normalize sub-sampled Cb and subtract
sub_cb_norm = sub_cb_norm - 128;    % 128 from all values in matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y_dct = blkproc(y_norm, [8 8], @dct2);          % This is the DCT of the
%round off                                      % (Y) Luminance Component
y_dct = fix(y_dct);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sub_Cr_dct = blkproc(sub_cr_norm, [8 8], @dct2);    % This is the DCT of the
%round off                                          % Sub-sampled Cr-Band
sub_Cr_dct = fix(sub_Cr_dct);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sub_Cb_dct = blkproc(sub_cb_norm, [8 8], @dct2);    % This is the DCT of the
%round off                                          % Sub-sampled Cb-Band
sub_Cb_dct = fix(sub_Cb_dct);

y_quantization_matrix = [16 11 10 16 24 40 51 61;
                         12 12 14 19 26 58 60 55;
                         14 13 16 24 40 57 69 56;
                         14 17 22 29 51 87 89 62;
                         18 22 37 56 68 109 103 77;
                         24 35 55 64 81 104 113 92;
                         49 64 78 87 108 121 120 101;
                         72 92 95 98 112 100 103 99];

cb_cr_quantization_matrix = [17 18 24 47 99 99 99 99;
                             18 21 26 66 99 99 99 99;
                             24 26 56 99 99 99 99 99;
                             47 66 99 99 99 99 99 99;
                             99 99 99 99 99 99 99 99;
                             99 99 99 99 99 99 99 99;
                             99 99 99 99 99 99 99 99;
                             99 99 99 99 99 99 99 99;];

y_dct_show_1 = y_dct(41:48, 1:8);
y_dct_show_2 = y_dct(41:48, 9:16);

disp('6th Row 1st Block of Y_DCT Coefficients');
disp(y_dct_show_1);
disp('6th Row 2nd Block of Y_DCT Coefficients');
disp(y_dct_show_2);

figure;
subplot(1, 2, 1);
imshow(y_dct_show_1);
title('6th Row 1st Block of Y_DCT');
subplot(1, 2, 2);
imshow(y_dct_show_2);
title('6th Row 2nd Block of Y_DCT');


% Folder = '.\';
% File   = 'SubCr.jpg';
% Img    = sub_Cr;
% imwrite(Img, fullfile(Folder, File));
% 
% Folder = '.\';
% File   = 'SubCb.jpg';
% Img    = sub_Cb;
% imwrite(Img, fullfile(Folder, File));

