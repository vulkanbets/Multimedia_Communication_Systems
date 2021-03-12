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
y_dct = blkproc(Y, [8 8], @dct2);               % This is the DCT of the
%round off                                      % (Y) Luminance Component
y_dct = fix(y_dct);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sub_Cr_dct = blkproc(sub_Cr, [8 8], @dct2);     % This is the DCT of the
%round off                                      % Sub-sampled Cr-Band
sub_Cr_dct = fix(sub_Cr_dct);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sub_Cb_dct = blkproc(sub_Cb, [8 8], @dct2);     % This is the DCT of the
%round off                                      % Sub-sampled Cb-Band
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







figure;
subplot(2, 2, [1, 2]);
imshow(y_dct);
subplot(2, 2, 3);
imshow(sub_Cr_dct);
subplot(2, 2, 4);
imshow(sub_Cb_dct);



%  Decoder
%  Reconstruct the image by computing Inverse DCT coefficients.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% y_reconstructed = blkproc(y_dct, [8 8], @idct2);
% %round off
% y_reconstructed = fix(y_reconstructed);
% y_reconstructed = uint8(y_reconstructed);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sub_Cr_dct_reconstructed = blkproc(sub_Cr_dct, [8 8], @idct2);
% %round off
% sub_Cr_dct_reconstructed = fix(sub_Cr_dct_reconstructed);
% sub_Cr_dct_reconstructed = uint8(sub_Cr_dct_reconstructed);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sub_Cb_dct_reconstructed = blkproc(sub_Cb_dct, [8 8], @idct2);
% %round off
% sub_Cb_dct_reconstructed = fix(sub_Cb_dct_reconstructed);
% sub_Cb_dct_reconstructed = uint8(sub_Cb_dct_reconstructed);



% figure;                             % 
% subplot(2, 2, [1, 2]);              % This code displays the Luminence (Y)
% imshow(Y);                          % 
% title('(Y) Luminance');             % 
% subplot(2, 2, 3);                   % This code displays both the
% imshow(sub_Cr);                     % 
% title('Cr 4:2:0 Subsampling');      % Cr and Cb Subsampled bands
% subplot(2, 2, 4);                   % 
% imshow(sub_Cb);                     % In one figure
% title('Cb 4:2:0 Subsampling');      % 


% Folder = '.\';
% File   = 'SubCr.jpg';
% Img    = sub_Cr;
% imwrite(Img, fullfile(Folder, File));
% 
% Folder = '.\';
% File   = 'SubCb.jpg';
% Img    = sub_Cb;
% imwrite(Img, fullfile(Folder, File));

