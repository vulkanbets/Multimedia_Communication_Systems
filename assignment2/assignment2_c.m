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



%%% Assign and Display the blocks to be shown for the report
block1 = y_quantized(41:48, 1:8);
block2 = y_quantized(41:48, 9:16);
%%% Assign and Display the blocks to be shown for the report




%%% Begin zig zag method and print of (Y) Luminance coefficient scan
row = uint8(1);
column = uint8(1);
flag = 0;   % Up = 1; Down = 0  Flag to go either up or down
zigzag_coefficients_1 = [];
zigzag_coefficients_2 = [];
for k = 1 : 64
    if ( ( row == 1 || row == 8) && (column == 1 || column == 3 || column == 5 || column == 7 ) ) % Move Right
        if(block1(row, column) ~= 0) zigzag_coefficients_1 = [zigzag_coefficients_1, block1(row, column)]; end
        if(block2(row, column) ~= 0) zigzag_coefficients_2 = [zigzag_coefficients_2, block2(row, column)]; end
        column = column + 1;
    elseif ( (row == 2 || row == 4 || row == 6)  &&  (column == 1 || column == 8) )   % Move Down
        if(block1(row, column) ~= 0) zigzag_coefficients_1 = [zigzag_coefficients_1, block1(row, column)]; end
        if(block2(row, column) ~= 0) zigzag_coefficients_2 = [zigzag_coefficients_2, block2(row, column)]; end
        row = row + 1;
    elseif(k == 64)
        if(block1(row, column) ~= 0) zigzag_coefficients_1 = [zigzag_coefficients_1, block1(row, column)]; end
        if(block2(row, column) ~= 0) zigzag_coefficients_2 = [zigzag_coefficients_2, block2(row, column)]; end
    else                    % Either move diagonal Up-Right or Down-Left
        if(flag == 0)       % Move diagonal Down-Left
            if(block1(row, column) ~= 0) zigzag_coefficients_1 = [zigzag_coefficients_1, block1(row, column)]; end
            if(block2(row, column) ~= 0) zigzag_coefficients_2 = [zigzag_coefficients_2, block2(row, column)]; end
            row = row + 1;
            column = column - 1;
            if(column == 1 || row == 8 && (column == 3 || column == 5 || column == 7)) flag = 1; end
        else                % Move diagonal Up-Right
            if(block1(row, column) ~= 0) zigzag_coefficients_1 = [zigzag_coefficients_1, block1(row, column)]; end
            if(block2(row, column) ~= 0) zigzag_coefficients_2 = [zigzag_coefficients_2, block2(row, column)]; end
            row = row - 1;
            column = column + 1;
            if( row == 1 || column == 8 && (row == 2 || row == 4 || row == 6) ) flag = 0; end
        end
    end
end
%%% End zig zag method and print of (Y) Luminance coefficient scan

sprintf( ' 1st block DC DCT coefficient  =  %d ', block1(1, 1) )
sprintf( ' 2nd block DC DCT coefficient  =  %d ', block2(1, 1) )
disp( 'These are the zig-zagged scanned coefficients for the 1st block')
disp(zigzag_coefficients_1)
disp( 'These are the zig-zagged scanned coefficients for the 2nd block')
disp(zigzag_coefficients_2)


% figure;
% subplot(2, 2, [1, 2]);
% imshow(y_dct);
% subplot(2, 2, 3);
% imshow(sub_Cb_dct);
% subplot(2, 2, 4);
% imshow(sub_Cr_dct);







%  Decoder
%  Reconstruct the image by computing Inverse DCT coefficients.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% y_reconstructed = blkproc(y_dct, [8 8], @idct2);
% %round off
% y_reconstructed = fix(y_reconstructed);
% % Convert back to jpeg format
% y_reconstructed = y_reconstructed + 128;
% y_reconstructed = uint8(y_reconstructed);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sub_Cr_dct_reconstructed = blkproc(sub_Cr_dct, [8 8], @idct2);
% %round off
% sub_Cr_dct_reconstructed = fix(sub_Cr_dct_reconstructed);
% % Convert back to jpeg format
% sub_Cr_dct_reconstructed = sub_Cr_dct_reconstructed + 128;
% sub_Cr_dct_reconstructed = uint8(sub_Cr_dct_reconstructed);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sub_Cb_dct_reconstructed = blkproc(sub_Cb_dct, [8 8], @idct2);
% %round off
% sub_Cb_dct_reconstructed = fix(sub_Cb_dct_reconstructed);
% % Convert back to jpeg format
% sub_Cb_dct_reconstructed = sub_Cb_dct_reconstructed + 128;
% sub_Cb_dct_reconstructed = uint8(sub_Cb_dct_reconstructed);



% figure;
% subplot(2, 2, [1, 2]);
% imshow(y_reconstructed);
% subplot(2, 2, 3);
% imshow(sub_Cr_dct_reconstructed);
% subplot(2, 2, 4);
% imshow(sub_Cb_dct_reconstructed);





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

