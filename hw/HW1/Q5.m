%% Initialization
clc; clear;

im1 = imread('goi1.jpg');
im1 = im2double(im1);
imshow(im1)

im2 = imread('goi2_downsampled.jpg');
im2 = im2double(im2);
imshow(im2)

%% Part a)

n = 12;
x1 = ones(n);
y1 = ones(n);
x2 = ones(n);
y2 = ones(n);

for i = 1:n
    figure(1);
    imshow(im1);
    [x1(i), y1(i)] = ginput(1);

    figure(2);
    imshow(im2);
    [x2(i), y2(i)] = ginput(1);
end

%% Part b)

tform = maketform('affine', [1 0 0; .5 1 0; 0 0 1]);
J = imtransform(I, tform);
