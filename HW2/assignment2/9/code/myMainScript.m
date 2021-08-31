%% MyMainScript

tic;
clc; clear;

%% Your code here

% ? report images save directory
DIR = '../images';

LC1 = imread('../data/LC1.png');
LC2 = imread('../data/LC2.jpg');

%% Local histogram equalization

% windowSize = [7, 7; 31, 31; 51, 51; 71, 71];
windowSize = [7, 31, 51, 71];

for i = 1:size(windowSize, 1)
    figure;
    subplot(1, 2, 1), imshow(LC1);
    title('Original image LC1');

    LC1_eq = myHistogramEquilization(LC1, windowSize(i));
    subplot(1, 2, 2), imshow(LC1_eq);
    title(sprintf('Local histogram equalization with window size %d', windowSize(i)));

    figure;
    subplot(1, 2, 1), imshow(LC2);
    title('Original image LC2');

    LC2_eq = myHistogramEquilization(LC2, windowSize(i));
    subplot(1, 2, 2), imshow(LC2_eq);
    title(sprintf('Local histogram equalization with window size %d', windowSize(i)));

    % save plot
    fileName = sprintf('bilateral_%d.png', noise_sigma(i));
    saveas(gcf, sprintf('../plots/myHistogramEqualization_%d.png', windowSize(i)));
    exportgraphics(gcf, fullfile(DIR, fileName), 'Resolution', 300);
end

toc;
% pause;
% close all;
