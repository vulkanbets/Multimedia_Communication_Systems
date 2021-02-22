% compE565 Homework 1
% Feb. 21, 2021
% Name: Juan Carlos Orlando
% ID: 822-401-873
% email: jorlando6216@sdsu.edu

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1: Read and display the image using Matlab
% M-file name: assignment1_1.m
% Location of output image: relative to the directory of README file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running "Read and display the miage using Matlab"');
assignment1_1;
disp('Done, "Read and display the image using Matlab", output image is "Original RGB Image.jpg"');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2: Display Each band (Red, Green, Blue) of the image file
% M-file name: assignment1_2.m
% Location of output image: relative to the directory of README file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running "Display Each band (Red, Green, Blue) of the image file"');
assignment1_2;
disp('Done, "Display Each band (Red, Green, Blue) of the image file" output image is "Red Band.jpg, Green Band.jpg and Blue Band.jpg"');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 3: Convert the Image int YCbCr space
% M-file name: assignment1_3.m
% Location of output image: There is no output image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running "Convert the Image int YCbCr space"\n');
assignment1_3;
disp('Done, "Convert the Image int YCbCr space"');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 4: Display each band separately
% M-file name: assignment1_4.m
% Location of output image: relative to the directory of README file @ Luminance (Y) Component.jpg, "Cb Component.jpg", and "Cb Component.jpg"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running "Display each band separately"\n');
assignment1_4;
disp('Done, "Convert the Image int YCbCr space" output images are @ "Luminance (Y) Component.jpg", "Cb Component.jpg", and "Cb Component.jpg"');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 5: Subsample Cb and Cr bands using 4:2:0 and display both bands
% M-file name: assignment1_5.m
% Location of output image: relative to the directory of README file @ "SubCr.jpg" and "SubCb.jpg"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running "Subsample Cb and Cr bands using 4:2:0 and display both bands"\n');
assignment1_5;
disp('Done, "Convert the Image int YCbCr space" output image is "SubCr.jpg" and "SubCb.jpg"');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 6: Upsample and display the Cb and Cr bands using 1) Linear Interpolation and 2) Row replication
% M-file name: assignment1_6_1.m & assignment1_6_2.m
% Location of output image: relative to the directory of README file @ "UpsampledCbInterpolation.jpg" and "UpsampledCrInterpolation.jpg" and "UpsampledCbRowReplicate.jpg" and "UpsampledCrRowReplicate.jpg"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running "Upsample and display the Cb and Cr bands using 1) Linear Interpolation and 2) Row replication"\n');
assignment1_6_1;
assignment1_6_2;
disp('Done, "Upsample and display the Cb and Cr bands using 1) Linear Interpolation and 2) Row replication\n"');
disp('output images are "UpsampledCbInterpolation.jpg" and "UpsampledCrInterpolation.jpg" and "UpsampledCbRowReplicate.jpg" and "UpsampledCrRowReplicate.jpg"');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 7: Convert the image into RGB format
% M-file name: assignment1_7.m
% Location of output image: There are no output images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running "Convert the image into RGB format"\n');
assignment1_7;
disp('Done, "Convert the image into RGB format"');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 8: Display the original and reconstructed images
% M-file name: assignment1_8.m
% Location of output image: relative to the directory of README file @ "interpolationRgb.jpg" and "replicationRgb.jpg"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running "Display the original and reconstructed images"\n');
assignment1_8;
disp('Done, "Display the original and reconstructed images" output images are "interpolationRgb.jpg" and "replicationRgb.jpg" ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 10: Measure MSE between the original and reconstructed images using the interpolated image
% M-file name: assignment1_10.m
% Location of output image: There are no output images, only console outputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running ""\n');
assignment1_10;
disp('Done, "Measure MSE between the original and reconstructed images using the interpolated image"');



