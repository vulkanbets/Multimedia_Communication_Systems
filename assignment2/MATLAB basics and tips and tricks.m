
%Basic MATLAB Commands and some tips and tricks
%----------------------------------------------

%DISCLAIMER: this is the very first draft of the very first tutorial
%that i ever wrote for the vert first MATLAB introduction presentation that
%i ever gave :) I will keep adding more to this until i feel that it is
%complete.

% Plesae copy paste the lines between %--->  and %<--- to see the example

% This is the .m file which the first slide talks about. When you copy a
% part of the code between the markers and paste it inside MATLAB, that is
% when you are accessing the command line directly. Normally when we write
% the whole program, we use this practice to gradually test the code that
% we write. The command line that we see in the "command window" in MATLAB
% is denoted by >> 

%"In the ‘real world’, its important to be able to think the way your enemy
%thinks, so that you are safe" 
%MATLAB thinks in 'matrices' and 'vectors'. However, in Image processsing
%we rarely use vectors, but we extensively use matrices. There are a
%zillion things we can achieve with matrix manipulations in image
%processing and moreover there are a zillion ways in which MATLAB lets us
%manipulate these matrices. I am covering the very basic matrix
%manipulations here and I am planning to add more to this section as i keep
%enhancing this tutorial.

%A forward decleration (i am a huge C++ fan)  :  MATLAB reads an image and
%stores it in the form for 3 differnt 2D matrices.
% we will look at how it happens at a later stage of this tutorial.

%Universal Truth #1 - Row by Column  -- this NEVER changes
%--->
%To define a matrix: (row by column) 
A = [1  2; 3  4] %2 by 2 matrix 

% A =
% 
%      1     2
%      3     4

B = [1; 2; 3; 4] %4 by 1 matrix  

% B =
% 
%      1
%      2
%      3
%      4
%<---
%NOTE - You cannot do A - B or A + B etc since the dimensions of the 
%matrices are different are different.


%Universal Truth #2 - Dimensions of the matrices have to be same to be able
%to perform any basic operations ( + - / * ) 
%Operations on matrices. - very basic ones with some interesting tricks.
%--->
% Addition & Subtraction
A = [1 2; 3 4] %2 by 2 matrix
B = [5 6; 7 8] %2 by 2 matrix

A + B
% >> A + B
% ans =
% 
%      6     8
%     10    12
    
B - A

% >> B - A
% 
% ans =
% 
%      4     4
%      4     4
%

%Multiplication : Normal and Element to Element
%To do a normal matrix multiplication (as we learnt in school)
A * B
% >> A * B
% 
% ans =
% 
%     19    22
%     43    50

%However in Image processing we rarely use this kind of multiplication.
%instead we use what i call 'element to element' kind of multiplication.
%this is the only way we can modify pixel values (as we see in the later
%section when i cover the image processing specific commands and how MATLAB
%stores images)
%we use the 'dot multiply' or the 'dot star' to acheive this.
A .* B
% >> A .* B
% 
% ans =
% 
%      5    12
%     21    32

%Similarly with Division. ('dot divide' or 'dot slash')
A / B
% >> A / B
% 
% ans =
% 
%     3.0000   -2.0000
%     2.0000   -1.0000
% 
A ./ B
% >> A ./ B
% 
% ans =
% 
%     0.2000    0.3333
%     0.4286    0.5000

%Yet another place the dot plays a very important role is when we need to
%raise every element in a matrix to a certain power. Say we want to square
%every element. This is extensively used in image processing.

%This squares every element
A .^2 

% >> A.^2
% 
% ans =
% 
%      1     4
%      9    16
% 
%This squares the matrix itself. This is equivalent to A*A

A^2 

% >> A^2
% 
% ans =
% 
%      7    10
%     15    22
 
A * A
% >> A*A
% 
% ans =
% 
%      7    10
%     15    22
% 
%<---

%In image processing, we often need to either split the matrix, or join 2
%matrices or remove rows or columns from a matrix.

%--->
%To split the matrix
A = [1 2 3; 4 5 6; 7 8 9]

% A =
% 
%      1     2     3
%      4     5     6
%      7     8     9
% 
a = A(:,3)

% >> a = A(:,3)
% 
% a =
% 
%      3
%      6
%      9
% 

b = A(:,1:2)

% >> b = A(:,1:2)
% 
% b =
% 
%      1     2
%      4     5
%      7     8

%to join a matrix - in image processing we often need to join 2 different
%parts of a picture. 

J = [a  b]

% J =
% 
%      3     1     2
%      6     4     5
%      9     7     8

%To remove a particular row or column we can do it very quickly. This is
%yet another technique extensively used in Image processing in case of
%compression algorithms like JPEG.


J(:,3) = [] 
% 
% J =
% 
%      3     1
%      6     4
%      9     7
%This removed the 3rd column.

%The transpose of a matrix is yet another operation used quite often in
%image processing.
%continuing from what J changed to......we do this...
Z = J'

% Z =
% 
%      3     6     9
%      1     4     7
%<---

%--->
%In the above examples I have used the : operator a lot. It is often called
%the range operator since it is mostly used to denote the range during
%matrix manipulations.

x = [1 2 3; 3 4 5; 6 7 8] 

% >> x = [1 2 3; 3 4 5; 5 6 6]
% 
% x =
% 
%      1     2     3
%      3     4     5
%      5     6     6
% 

%When you want to extract only a part of the whole matrix you do this.
x(1:2 , 1:2)

% >> x(1:2 , 1:2)
% 
% ans =
% 
%      1     2
%      3     4
% 
%When you want to extract a part of the matrix in such a way that it skips
%certain rows or cols..this is the way :)
x(1:2:3 , 1:2:3)

% >> x(1:2:3 , 1:2:3)
% 
% ans =
% 
%      1     3
%      5     6

%To generate a range of integers.
x = 6 : 10  

% x =
% 
%      6     7     8     9    10
% 

%To generate a rage of numbers in  steps
x = 1 : 2 : 10
% 
% x =
% 
%      1     3     5     7     9

%Using the range operator to access the colums or rows
x = [2 3 4; 5 6 7];

%To access all the colums but just the 1st row
x(1,:)
% >> x = [2 3 4; 5 6 7]; 
% >> x(1,:)
% 
% ans =
% 
%      2     3     4
% 

%To access all the rows but just the 1st column
x(:,1)

% >> x(:,1)
% 
% ans =
% 
%      2
%      5

%in MATLAB couting starts from 1 (not from 0 as in C) 
%consder a 2D matrix. if we want to access the 1st element using C we would
%do something like this  A(0,0). However it will give an error in MATLAB
A = [1 2 3 4; 1 2 3 4];

A(1,1)
%>> A(1,1)
%ans =
%1

A(0,0)

%   >> A(0,0)
%   ??? Subscript indices must either be real positive integers or logicals.
%<---

% Some very basic commands that we use in MATLAB to debug our code,
% expecially in Image processing tasks. 
% whos command gives a list of all the current variables stored in the
% memory in MATLAB and their size and class as show below.
whos
%--->
%  >> whos
%   Name      Size                    Bytes  Class
% 
%   A         2x4                        64  double array
%   a         3x2                        48  double array
%   ans       1x1                         8  double array
%   x         2x3                        48  double array
% 
% Grand total is 21 elements using 168 bytes
%<---

%--->
%the size and the length function can be used of any type of variable that
%we use in MATLAB. The size will essentially return the dimensions of the
%variable. In the most simple case it is a 1x1 matrix which implies one
%simmple number :)   
%The length function on the other hand returns the legnth of the variable
%in our case will be equal to the number of rows (not columns)

A = [ 1 2; 3 4]
size(A)
% >> size(A)
% 
% ans =
% 
%      2     2

length(A)
% 
% >> length(A)
% 
% ans =
% 
%      2
%<---

%Now we come to the real example of Image processing using MATLAB. I will 
% combine a lot of useful image processing functions into this simple
% program which essentially reads shows the info about an image file, reads 
% the image into a matrix, displays its RGB components, manipulates the 
% rows columns. Then it converts the RGB image to a YCbCr component image.
%Additionally this code also performs a Discrete Cosine Transform over the
%liuminance component of the image to show how block processing is done in 
%MATLAB.
%******************************************
% 
%***************************************

%clears all the variables in the MATLAB memory. Always a good practice.
clear all
%To know more about the image type etc..
imfinfo('g:/landscape.jpg')
%To read the image we simply use the imread function from the IP toolbox
RGBImage = imread('g:/landscape.jpg','jpg');
%To see the image.
figure(1)
imshow(RGBImage);
%To see how MATLAB has stored the image.. you will see it stores it in a
%3D matrix form ( or rather a set of three, two dimensional matrices)
size(RGBImage)

% Make 3 copies
R_Component = RGBImage;
G_Component = RGBImage;
B_Component = RGBImage;

%To obtain R G B components. We need to make the other 2 components=0 so
%that we can see the individual components.
for columns=1:640
    for rows=1:480
        G_Component(rows,columns,1)=0; %green component
        G_Component(rows,columns,3)=0;
        R_Component(rows,columns,2)=0; %red component
        R_Component(rows,columns,3)=0;
        B_Component(rows,columns,1)=0; %blue component
        B_Component(rows,columns,2)=0;
    end
end
%!!!!!There is shortcut to the above method. You can figure it out :)

% Display the Original RGB image and each component individually
figure(1);
subplot(2,2,1), subimage(RGBImage), title('Orignal RGB Image')
subplot(2,2,2), subimage(R_Component), title('Red Component')
subplot(2,2,3), subimage(G_Component), title('Green Component')
subplot(2,2,4), subimage(B_Component), title('Blue Component')

% Convert the RGB image ito YCbCr image
YCbCr_Image = rgb2ycbcr(RGBImage);
figure(2);
imshow(YCbCr_Image)
% Convert the RGB image ito Grayscale image
Gray_Image = rgb2gray(RGBImage); 
figure(3);
imshow(Gray_Image)

%Lets play around with the Y component of the image.
%Say if I want to make remove alternate colums in the grayscale image

Gray_Image(:,1:2:640) = [];
figure(4);
imshow(Gray_Image)

%Block processing..
%in JPEG Compression we perform DCT (Discrete Cosine Transform) over 8x8
%blocks in the image. Block processing becomes really important in image
%processing.

%first we extract the Y component
Y_component = YCbCr_Image(:,:,1);

pDCT = @dct2  
my_DCT = blkproc (Y_component, [8 8], pDCT);
%round off
my_DCT = fix(my_DCT);

figure(5);
imshow(my_DCT);





