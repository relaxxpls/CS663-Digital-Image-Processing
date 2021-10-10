%% MyMainScript

tic;
clc; clear;

%% Your code here

% ? resulting images path
DIR = '../images';

barbara = imread('../data/barbara256.png');
kodak = imread('../data/kodak24.png');
% imshow(barbara);
% title('Original image');

% ? noise level
noise_sigma = [5, 10];

% ? Neighbours
N = 200;

% ? Spatial domain sigma
sigma_s = [2, 0.1, 3];

% ? Range domain sigma
sigma_r = [2, 0.1, 15];

for i = 1:length(noise_sigma)
    % * Barbara

    % ? Add Gaussian noise
    noisy_barbara = double(barbara) + noise_sigma(i) * randn(size(barbara));
    noisy_barbara = uint8(noisy_barbara);

    figure;
    subplot(2, 2, 1), imshow(noisy_barbara);
    title(sprintf('Noisy barbara (\\sigma = %d)', noise_sigma(i)));

    % ? Denoise using bilateral filtering
    for j = 1:length(sigma_s)
        filtered_barbara = myMeanShiftSegmentation(noisy_barbara, sigma_s(j), sigma_r(j), N, 20);
        filtered_barbara = uint8(filtered_barbara);

        subplot(2, 2, 1 + j), imshow(filtered_barbara);
        title(sprintf('Filtered barbara (\\sigma_s: %.2f, \\sigma_r: %.2f)', sigma_s(j), sigma_r(j)));
    end

    fileName = sprintf('barbara_bilateral_%d.png', noise_sigma(i));
    exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);

    % % * Kodak

    % % ? Add Gaussian noise
    % noisy_kodak = double(kodak) + noise_sigma(i) * randn(size(kodak));
    % noisy_kodak = uint8(noisy_kodak);

    % figure;
    % subplot(2, 2, 1), imshow(noisy_kodak);
    % title(sprintf('Noisy kodak (\\sigma: %d)', noise_sigma(i)));

    % % ? Denoise using bilateral filtering
    % for j = 1:length(sigma_s)
    %     denoised_kodak = mybilateralfilter(noisy_kodak, sigma_s(j), sigma_r(j), w);
    %     denoised_kodak = uint8(denoised_kodak);

    %     subplot(2, 2, 1 + j), imshow(denoised_kodak);
    %     title(sprintf('Filtered kodak (\\sigma_s: %.2f, \\sigma_r: %.2f)', sigma_s(j), sigma_r(j)));
    % end

    % fileName = sprintf('kodak_bilateral_%d.png', noise_sigma(i));
    % exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);
end

toc;
pause;
close all;
