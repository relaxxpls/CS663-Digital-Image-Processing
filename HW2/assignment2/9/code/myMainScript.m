%% MyMainScript

tic;
clc; clear;

%% Your code here

% ? report images save directory
DIR = '../images';

LC1 = imread('../data/LC1.png');
LC2 = imread('../data/LC2.jpg');

%% Local histogram equalization

windowSize = [7, 31, 51, 71];

for i = 1:4
    figure;
    subplot(2, 2, 1), imshow(LC1);
    title('LC1 - original');

    LC1_eq = myHistogramEquilization(LC1, windowSize(i));
    subplot(2, 2, 2), imshow(LC1_eq);
    title(sprintf('LC1 - Local histogram equalization (%d x %d)', windowSize(i), windowSize(i)));

    subplot(2, 2, 3), imshow(LC2);
    title('LC2 - original');

    LC2_eq = myHistogramEquilization(LC2, windowSize(i));
    subplot(2, 2, 4), imshow(LC2_eq);
    title(sprintf('LC2 - Local histogram equalization (%d x %d)', windowSize(i), windowSize(i)));

    % ? save plot
    % fileName = sprintf('LocalHistogramEquilization_%dx%d.png', windowSize(i), windowSize(i));
    % exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);
end

%% Global histogram equalization

figure;
subplot(2, 2, 1), imshow(LC1);
title('LC1 - original');

LC1_global_eq = histeq(LC1);
subplot(2, 2, 2), imshow(LC1_global_eq);
title('LC1 - Global histogram equalization');

subplot(2, 2, 3), imshow(LC2);
title('LC2 - original');

LC2_global_eq = histeq(LC2);
subplot(2, 2, 4), imshow(LC2_global_eq);
title('LC2 - Global histogram equalization');

% ? save plot
% fileName = 'GlobalHistogramEquilization.png';
% exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);

toc;
% pause;
close all;
