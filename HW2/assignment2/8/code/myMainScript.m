%% MyMainScript

tic;
clc; clear;
%% Your code here

DIR = '../images';

barbara = imread('../data/barbara256.png');
subplot(1, 2, 1), imshow(barbara);
title('Original image');

%% Noisy image with sigma 5

sigma_1 = 5;
% ? Add Gaussian noise
barbara_noisy_1 = double(barbara) + sigma_1 * randn(size(barbara));
% ? round the pixel values, bring them in the range [0 255] and convert to double format
barbara_noisy_1 = uint8(barbara_noisy_1);

subplot(1, 2, 2), imshow(barbara_noisy_1);
title('Noisy image (\sigma = 5)');

%% Denoising using bilateral filtering

% ? window size
w = 5;
% ? Spatial domain sigma
sigma_s = [2, 0.1, 3];
% ? Range domain sigma
sigma_r = [2, 0.1, 15];

for i = 1:3
    % barbara_filtered = uint8(myBilateralFilter(barbara_noisy_1, sigma_s(i), sigma_r(i), w));

    figure;
    subplot(1, 2, 1), imshow(barbara_noisy_1);
    title('Noisy image');
    % subplot(1, 2, 2), imshow(barbara_filtered);
    title(['Filtered image (\sigma_s = ', num2str(sigma_s(i)), ', \sigma_r = ', num2str(sigma_r(i)), ')']);
    break;
end

% barbara_filtered_1a = myBilateralFilter(barbara_noisy, 5, 2, 2);
% barbara_filtered_1b = myBilateralFilter(barbara_noisy, 5, 0.1, 0.1);
% barbara_filtered_1c = myBilateralFilter(barbara_noisy, 5, 3, 15);

% subplot(1, 2, 2), imshow(barbara_tst)
% title('Noisy image')
% barbara_noisy2 = barbara + 10 * randn(size(barbara));
% barbara_filtered_2a = myBilateralFilter(barbara_noisy, 5, 2, 2);
% barbara_filtered_2b = myBilateralFilter(barbara_noisy, 5, 0.1, 0.1);
% barbara_filtered_2c = myBilateralFilter(barbara_noisy, 5, 3, 15);

toc;
