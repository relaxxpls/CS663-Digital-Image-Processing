%% MyMainScript

tic;
clc; clear;

%% Your code here

% ? resulting images path
DIR = '../images';

barbara = imread('../data/barbara256.png');
% imshow(barbara);
% title('Original image');

% ? noise level
noise_sigma = [5, 10];

% ? window size (each side)
w = 5;

% ? Spatial domain sigma
sigma_s = [2, 0.1, 3];

% ? Range domain sigma
sigma_r = [2, 0.1, 15];

for i = 1:length(noise_sigma)
    % ? Add Gaussian noise
    noisy_barbara = double(barbara) + noise_sigma(i) * randn(size(barbara));
    noisy_barbara = uint8(noisy_barbara);

    figure(i);
    subplot(2, 2, 1), imshow(noisy_barbara);
    title(sprintf('Noisy image (\\sigma = %d)', noise_sigma(i)));

    % ? Denoise using bilateral filtering
    for j = 1:length(sigma_s)
        denoised_barbara = mybilateralfilter(noisy_barbara, sigma_s(j), sigma_r(j), w);
        denoised_barbara = uint8(denoised_barbara);

        subplot(2, 2, 1 + j), imshow(denoised_barbara);
        title(sprintf('Filtered image (\\sigma_s = %.2f, \\sigma_r = %.2f)', sigma_s(j), sigma_r(j)));
    end

    % fileName = sprintf('bilateral_%d.png', noise_sigma(i));
    % exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);
end

toc;
pause;
close all;
