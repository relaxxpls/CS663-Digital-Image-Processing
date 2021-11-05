%% MyMainScript

tic;
clc; clear;

%% Your code here

% ? resulting images path
DIR = '../images';

% ? Neighbours
N = 200;

% ? noise level
sigma = 20;

barbara = imread('../data/barbara256.png');
stream = imread('../data/stream.png');
stream = stream(1:256, 1:256);

%% Part A)
noisy_stream = double(stream) + sigma * randn(size(stream));
figure, imshow(noisy_stream);

denoised_stream1 = myPCADenoising1(noisy_stream, sigma);
figure, imshow(denoised_stream1);

RMSE1 = sqrt(mean((noisy_stream(:) - denoised_stream1(:)).^2));
disp(RMSE1);

%% Part B)
denoised_stream2 = myPCADenoising2(noisy_stream, sigma);
figure, imshow(denoised_stream2);

RMSE2 = sqrt(mean((noisy_stream(:) - denoised_stream2(:)).^2));
disp(RMSE2);

toc;
