%% MyMainScript

tic;
clc; clear;

%% Your code here

% ? resulting images path
DIR = '../images';

barbara = imread('../data/barbara256.png');
figure;
imshow(barbara);
title('Original image');

% ? noise level
noise_sigma = [5, 10];

% ? window size (each side)
w = 5;

% ? Spatial domain sigma
sigma_s = [2, 0.1, 3];

% ? Range domain sigma
sigma_r = [2, 0.1, 15];

for i = 1:length(noise_sigma)
    figure;
    subplot(1 + length(sigma_s), 2, 1), imshow(barbara);
    title('Original image');

    % ? Add Gaussian noise
    noisy_barbara = double(barbara) + noise_sigma(i) * randn(size(barbara));
    noisy_barbara = uint8(noisy_barbara);

    subplot(1, 2, 2), imshow(noisy_barbara);
    title(sprintf('Noisy image (\\sigma = %d)', noise_sigma(i)));

    % ? Denoise using bilateral filtering
    for j = 1:length(sigma_s)
        denoised_barbara = mybilateralfilter(noisy_barbara, sigma_s(j), sigma_r(j), w);
        denoised_barbara = uint8(denoised_barbara);

        figure;
        subplot(1, 2, 1), imshow(noisy_barbara);
        title(sprintf('Noisy image (\\sigma = %d)', noise_sigma(i)));

        subplot(1, 2, 2), imshow(denoised_barbara);
        title(sprintf('Filtered image (\\sigma_s = %d, \\sigma_r = %d)', sigma_s(j), sigma_r(j)));
    end

end

toc;
pause;
close all;

%{
% ? Add Gaussian noise
barbara_noisy_1 = double(barbara) + noise_sigma_1 * randn(size(barbara));
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
    barbara_filtered = uint8(mybilateralfilter(barbara_noisy_1, sigma_s(i), sigma_r(i), w));

    figure;
    subplot(1, 2, 1), imshow(barbara_noisy_1);
    title('Noisy image');
    subplot(1, 2, 2), imshow(barbara_filtered);
    title(['Filtered image (\sigma_s = ', num2str(sigma_s(i)), ', \sigma_r = ', num2str(sigma_r(i)), ')']);
    break
end

%}

% subplot(1, 2, 2), imshow(barbara_tst)
% title('Noisy image')
% barbara_noisy2 = barbara + 10 * randn(size(barbara));
% barbara_filtered_2a = myBilateralFilter(barbara_noisy, 5, 2, 2);
% barbara_filtered_2b = myBilateralFilter(barbara_noisy, 5, 0.1, 0.1);
% barbara_filtered_2c = myBilateralFilter(barbara_noisy, 5, 3, 15);
