%% MyMainScript

tic;
clc; clear;
%% Your code here

LC1 = imread('../data/LC1.png');
LC2 = imread('../data/LC2.jpg');

% Local histogram equalization

windowSize = [7, 7; 31, 31; 51, 51; 71, 71];

for i = 1:size(windowSize, 1)
    LC1_eq = myHistogramEquilization(LC1, windowSize(i, :));
    LC2_eq = myHistogramEquilization(LC1, windowSize(i, :));
    break
end

%

%

toc;
pause;
close all;
