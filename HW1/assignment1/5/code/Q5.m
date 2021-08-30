%% Initialization
% clc; clear;

im1 = imread('goi1.jpg');
im1 = im2double(im1);
imshow(im1)

im2 = imread('goi2_downsampled.jpg');
im2 = im2double(im2);
imshow(im2)

%% Part a) We need to warp im1 (moving image) to im2 (fixed image)

N = 12;

% movingPoints = A * fixedPoints
movingPts = ones(3, N);
fixedPts = ones(3, N);

for idx = 1:N
    figure(1);
    imshow(im1);
    [movingPts(1, idx), movingPts(2, idx)] = ginput(1);

    figure(2);
    imshow(im2);
    [fixedPts(1, idx), fixedPts(2, idx)] = ginput(1);
end

%% Part b) determining the affine transform matrix

% ? movingPts = A * fixedPts
% ? movingPts * fixedPts' = A * fixedPts * fixedPts'
% ? A = (movingPts * fixedPts') * (fixedPts * fixedPts')^-1

A = (movingPts * fixedPts') * pinv(fixedPts * fixedPts');

img3 = NearestNeighborInterpolation(im1, A);

figure(1);
imshow(img3);
DIR = 'report';
exportgraphics(gcf, fullfile(DIR, 'Nearest Neighbour Interpolation.png'), 'Resolution', 300);
