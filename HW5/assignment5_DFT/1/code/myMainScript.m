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
noisy_stream = uint8(noisy_stream);
figure, imshow(noisy_stream);
fileName = 'noisy stream.png';
exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);

denoised_stream1 = myPCADenoising1(double(noisy_stream), sigma);
figure, imshow(denoised_stream1);
fileName = 'denoised stream 1.png';
exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);

RMSE1 = sqrt(mean((noisy_stream(:) - denoised_stream1(:)).^2));
disp(RMSE1);

%% Part B)
denoised_stream2 = myPCADenoising2(double(noisy_stream), sigma);
figure, imshow(denoised_stream2);

RMSE2 = sqrt(mean((noisy_stream(:) - denoised_stream2(:)).^2));
disp(RMSE2);

fileName = 'denoised stream 2.png';
exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);

toc;
