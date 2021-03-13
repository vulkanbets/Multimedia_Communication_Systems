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

%  !!!!!  ENCODER  !!!!!
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


% Quantize the Y (Luminance) by dividing by the (Y) quantization Matrix
% (Y) Luminance quantization Matrix
myfun = @(block_struct) rdivide(block_struct.data, y_quantization_matrix);
y_quantized = blockproc(y_dct, [8 8], myfun);
%round off
y_quantized = fix(y_quantized);
% convert to 32-bit
y_quantized = int32(y_quantized);

% Quantize the Cb Band by dividing by the Cb Cr quantization Matrix
sub_Cb_dct_padded = padarray(sub_Cb_dct, 4, 0, 'post');
myfun2 = @(block_struct) rdivide(block_struct.data, cb_cr_quantization_matrix);
sub_Cb_quantized = blockproc(sub_Cb_dct_padded, [8 8], myfun2);
%round off
sub_Cb_quantized = fix(sub_Cb_quantized);
% convert to 32-bit
sub_Cb_quantized = int32(sub_Cb_quantized);


% Quantize the Cr Band by dividing by the Cb Cr quantization Matrix
sub_Cr_dct_padded = padarray(sub_Cr_dct, 4, 0, 'post');
myfun3 = @(block_struct) rdivide(block_struct.data, cb_cr_quantization_matrix);
sub_Cr_quantized = blockproc(sub_Cr_dct_padded, [8 8], myfun3);
%round off
sub_Cr_quantized = fix(sub_Cr_quantized);
% convert to 32-bit
sub_Cr_quantized = int32(sub_Cr_quantized);



%  !!!!!  DECODER  !!!!!
%  Inverse Quantize the Y (Luminance) by multiplying
%  by the (Y) quantization Matrix
myfun4 = @(block_struct) times(block_struct.data, y_quantization_matrix);
y_quantized = double(y_quantized);
inverse_y_quantized = blockproc(y_quantized, [8 8], myfun4);
% Inverse Quantize the Cb Band by multiplying by the Cb Cr quantization Matrix
myfun5 = @(block_struct) times(block_struct.data, cb_cr_quantization_matrix);
sub_Cb_quantized = double(sub_Cb_quantized);
inverse_sub_Cb_quantized = blockproc(sub_Cb_quantized, [8 8], myfun5);
inverse_sub_Cb_quantized = inverse_sub_Cb_quantized(1:268, 1:352);
% Inverse Quantize the Cr Band by multiplying by the Cb Cr quantization Matrix
myfun6 = @(block_struct) times(block_struct.data, cb_cr_quantization_matrix);
sub_Cr_quantized = double(sub_Cr_quantized);
inverse_sub_Cr_quantized = blockproc(sub_Cr_quantized, [8 8], myfun6);
inverse_sub_Cr_quantized = inverse_sub_Cr_quantized(1:268, 1:352);



%  Reconstruct the image by computing Inverse DCT coefficients.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y_reconstructed = blkproc(inverse_y_quantized, [8 8], @idct2);
%round off
y_reconstructed = fix(y_reconstructed);
% Convert back to jpeg format
y_reconstructed = y_reconstructed + 128;
y_reconstructed = uint8(y_reconstructed);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sub_Cr_dct_reconstructed = blkproc(inverse_sub_Cr_quantized, [8 8], @idct2);
%round off
sub_Cr_dct_reconstructed = fix(sub_Cr_dct_reconstructed);
% Convert back to jpeg format
sub_Cr_dct_reconstructed = sub_Cr_dct_reconstructed + 128;
sub_Cr_dct_reconstructed = uint8(sub_Cr_dct_reconstructed);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sub_Cb_dct_reconstructed = blkproc(inverse_sub_Cb_quantized, [8 8], @idct2);
%round off
sub_Cb_dct_reconstructed = fix(sub_Cb_dct_reconstructed);
% Convert back to jpeg format
sub_Cb_dct_reconstructed = sub_Cb_dct_reconstructed + 128;
sub_Cb_dct_reconstructed = uint8(sub_Cb_dct_reconstructed);



up_Cr = zeros( (rows), (columns), 'uint8' );        % fill Upsampled array with 0's
up_Cb = zeros( (rows), (columns), 'uint8' );        % fill Upsampled array with 0's
x = 1;                                  % Rows
y = 1;                                  % Columns
for i = 1:1:rows
    for j = 1:1:columns
        % Upsampling Linear Interpolation
        if( mod(i, 2) == 1 )                % Odd Row
            if( mod(j, 2) == 1 )            % Odd Row Odd Column
                up_Cr(i, j) = sub_Cr_dct_reconstructed(x, y);
                up_Cb(i, j) = sub_Cb_dct_reconstructed(x, y);
            else                            % Odd Row Even Column
                if(j == columns)
                    up_Cr(i, j) = sub_Cr_dct_reconstructed(x, y);     % Last column of pixels (edge case)
                    up_Cb(i, j) = sub_Cb_dct_reconstructed(x, y);     % Last column of pixels (edge case)
                else
                    up_Cr(i, j) = (sub_Cr_dct_reconstructed(x, y))/2 + (sub_Cr_dct_reconstructed(x, y+1))/2;    % average of left and right pixels
                    up_Cb(i, j) = (sub_Cb_dct_reconstructed(x, y))/2 + (sub_Cb_dct_reconstructed(x, y+1))/2;    % average of left and right pixels
                end
            end
        else                                            % Even Row
            if(i == rows)
                up_Cr(i, j) = sub_Cr_dct_reconstructed(x, y);               % Last row of pixels (edge case)
                up_Cb(i, j) = sub_Cb_dct_reconstructed(x, y);               % Last row of pixels (edge case)
            else                                                            % 
                up_Cr(i, j) = (sub_Cr_dct_reconstructed(x, y))/2 + sub_Cr_dct_reconstructed(x+1, y)/2;      % average of pixels above and below
                up_Cb(i, j) = (sub_Cb_dct_reconstructed(x, y))/2 + sub_Cb_dct_reconstructed(x+1, y)/2;      % average of pixels above and below
            end
        end
        if( mod(j, 2) == 0 ) y = y + 1; end
    end
    if( mod(i, 2) == 0 ) x = x + 1; end
    y = 1;
end

Reconstructed_RgbImage = cat(3, y_reconstructed, up_Cr, up_Cb);   % This converts back to RGB
Reconstructed_RgbImage = ycbcr2rgb(Reconstructed_RgbImage);

%  This is to display the Y Cb Cr components
% figure;
% subplot(2, 2, [1, 2]);
% imshow(y_reconstructed);
% subplot(2, 2, 3);
% imshow(up_Cr);
% subplot(2, 2, 4);
% imshow(up_Cb);


%  This is to display the Reconstructed images
% figure;
% imshow(Reconstructed_RgbImage);
% title('Reconstructed Image back to RGB');

%  This is to compare the reconstructed image with the original
% figure;
% subplot(1, 2, 1);
% imshow(Reconstructed_RgbImage);
% title('Reconstructed Image back to RGB');
% subplot(1, 2, 2);
% imshow(rgbImage);
% title('Original RGB Image');

%  This is to display the error image
% error_image = imsubtract(rgbImage, Reconstructed_RgbImage)
% figure;
% imshow(error_image);
% title('Error Image');



