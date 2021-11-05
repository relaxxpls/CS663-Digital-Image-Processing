%% MyMainScript

tic;
clc; clear;
%% Your code here

% ? resulting images path
DIR = '../images';

barbara = imread('../data/barbara256.png');

[m, n] = size(barbara);
barbara = padarray(barbara, [m / 2, n / 2], 0);

fft_barbara = fftshift(fft2(barbara));
figure;
imshow(log(1 + abs(fft_barbara)), []);
colormap jet;
colorbar;

vars = [40, 80];
H11 = zeros(2 * m, 2 * n);
H12 = zeros(2 * m, 2 * n);
H21 = zeros(2 * m, 2 * n);
H22 = zeros(2 * m, 2 * n);

for i = 1:2 * m

    for j = 1:2 * n

        if (i - m)^2 + (j - n)^2 <= vars(1)^2
            H11(i, j) = 1;
        end

        if (i - m)^2 + (j - n)^2 <= vars(2)^2
            H12(i, j) = 1;
        end

        H21(i, j) = exp(-((i - m)^2 + (j - n)^2) / (2 * vars(1)^2));

        H22(i, j) = exp(-((i - m)^2 + (j - n)^2) / (2 * vars(2)^2));

    end

end

img11 = ifft2(ifftshift(fft_barbara .* H11));
img11 = img11(m / 2 + 1:3 * m / 2, n / 2 + 1:3 * n / 2);
figure;
imshow(real(img11), []);
exportgraphics(gcf, fullfile(DIR, 'ideal_40_image.png'), 'Resolution', 300);

img12 = ifft2(ifftshift(fft_barbara .* H12));
img12 = img12(m / 2 + 1:3 * m / 2, n / 2 + 1:3 * n / 2);
figure;
imshow(real(img12), []);
exportgraphics(gcf, fullfile(DIR, 'ideal_80_image.png'), 'Resolution', 300);

img21 = ifft2(ifftshift(fft_barbara .* H21));
img21 = img21(m / 2 + 1:3 * m / 2, n / 2 + 1:3 * n / 2);
figure;
imshow(real(img21), []);
exportgraphics(gcf, fullfile(DIR, 'gaussian_40_image.png'), 'Resolution', 300);

img22 = ifft2(ifftshift(fft_barbara .* H22));
img22 = img22(m / 2 + 1:3 * m / 2, n / 2 + 1:3 * n / 2);
figure;
imshow(real(img22), []);
exportgraphics(gcf, fullfile(DIR, 'gaussian_80_image.png'), 'Resolution', 300);

figure;
imshow(H11, [min(abs(H11(:))) max(abs(H11(:)))]);
colormap jet;
colorbar;
exportgraphics(gcf, fullfile(DIR, 'ideal_40_filter.png'), 'Resolution', 300);

figure;
imshow(H12, [min(abs(H12(:))) max(abs(H12(:)))]);
colormap jet;
colorbar;
exportgraphics(gcf, fullfile(DIR, 'ideal_80_filter.png'), 'Resolution', 300);

figure;
imshow(H21, [min(abs(H21(:))) max(abs(H21(:)))]);
colormap jet;
colorbar;
exportgraphics(gcf, fullfile(DIR, 'gaussian_40_filter.png'), 'Resolution', 300);

figure;
imshow(H22, [min(abs(H22(:))) max(abs(H22(:)))]);
colormap jet;
colorbar;
exportgraphics(gcf, fullfile(DIR, 'gaussian_80_filter.png'), 'Resolution', 300);

toc;
