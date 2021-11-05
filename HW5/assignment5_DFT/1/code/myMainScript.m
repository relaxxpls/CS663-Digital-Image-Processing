%% MyMainScript

tic;
clc; clear;

%% Your code here

% ? resulting images path
DIR = '../images';

barbara = imread('../data/barbara256.png');
stream = imread('../data/stream.png');
stream = stream(1:256, 1:256);

noisy_stream = double(stream) + 20 * randn(size(stream));
noisy_stream = uint8(noisy_stream);

imshow(noisy_stream);
denoised_stream = myPCADenoising1(noisy_stream, 20);
imshow(denoised_stream);

% % ? noise level
% noise_sigma = [5, 10];

% % ? Neighbours
% N = 200;

% % ? Spatial domain sigma
% sigma_s = [2, 0.1, 3];

% % ? Range domain sigma
% sigma_r = [2, 0.1, 15];

% for i = 1:length(noise_sigma)
%     % * Barbara

%     % ? Add Gaussian noise
%     noisy_barbara = double(barbara) + noise_sigma(i) * randn(size(barbara));
%     noisy_barbara = uint8(noisy_barbara);

%     figure;
%     subplot(2, 2, 1), imshow(noisy_barbara);
%     title(sprintf('Noisy barbara (\\sigma = %d)', noise_sigma(i)));

%     % ? Denoise using meanshift filtering
%     for j = 1:length(sigma_s)
%         filtered_barbara = myMeanShiftSegmentation(noisy_barbara, sigma_s(j), sigma_r(j));

%         subplot(2, 2, 1 + j), imshow(filtered_barbara);
%         title(sprintf('Filtered barbara (\\sigma_s: %.2f, \\sigma_r: %.2f)', sigma_s(j), sigma_r(j)));
%     end

%     fileName = sprintf('barbara_meanshift_%d.png', noise_sigma(i));
%     exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);

%     % * Kodak

%     % ? Add Gaussian noise
%     noisy_kodak = double(kodak) + noise_sigma(i) * randn(size(kodak));
%     noisy_kodak = uint8(noisy_kodak);

%     figure;
%     subplot(2, 2, 1), imshow(noisy_kodak);
%     title(sprintf('Noisy kodak (\\sigma: %d)', noise_sigma(i)));

%     % ? Denoise using meanshift filtering
%     for j = 1:length(sigma_s)
%         filtered_kodak = myMeanShiftSegmentation(noisy_kodak, sigma_s(j), sigma_r(j));

%         subplot(2, 2, 1 + j), imshow(filtered_kodak);
%         title(sprintf('Filtered kodak (\\sigma_s: %.2f, \\sigma_r: %.2f)', sigma_s(j), sigma_r(j)));
%     end

%     fileName = sprintf('kodak_meanshift_%d.png', noise_sigma(i));
%     exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);
% end

toc;
pause;
close all;
