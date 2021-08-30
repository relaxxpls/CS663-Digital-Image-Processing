clc; clear;
%%
J1 = imread('T1.jpg');
% imshow(J1)

J2 = imread('T1.jpg');
% imshow(J2)

%% Part a)

J3 = imrotate(J2, 28.5, 'crop');
% imshow(J3)

%% Part b)

[m, n] = size(J1);
degrees = -45:45;
d_n = length(degrees);
bin = 10;

QMI = zeros(d_n, 1);
JE = zeros(d_n, 1);
NCC = zeros(d_n, 1);

for idx = 1:d_n
    deg = degrees(idx);

    J4 = imrotate(J3, deg, 'crop');

    ht = JointHistogram(J4, J1, bin, true);

    I1 = double(J4(:));
    I2 = double(J1(:));

    % joint histogram of J1 & J4
    min1 = min(I1); max1 = max(I1);
    min2 = min(I2); max2 = max(I2);
    N1 = 1 + uint8(max1 - min1) / bin;
    N2 = 1 + uint8(max2 - min2) / bin;

    mean1 = mean(I1); mean2 = mean(I2);
    sum1 = 0.0; sum2 = 0.0;
    CC = 0.0; % cross correlation

    for pos = 1:m * n
        % normalised cross correlation
        CC = CC + (I1(pos) - mean1) * (I2(pos) - mean2);
        sum1 = sum1 + (I1(pos) - mean1)^2;
        sum2 = sum2 + (I2(pos) - mean2)^2;
    end

    NCC(idx) = CC / sqrt(sum1 * sum2); % normalisation

    xm = sum(ht, 2); xm = xm(:);
    ym = sum(ht, 1); ym = ym(:);

    for r = 1:N1

        for c = 1:N2
            % joint entropy
            if ht(r, c) > 0
                JE(idx) = JE(idx) - ht(r, c) * log2(ht(r, c));
            end

            % quadratic mutual information
            QMI(idx) = QMI(idx) + (ht(r, c) - ym(r) * xm(c))^2;
        end

    end

end

DIR = 'report';

figure(1);
plot(degrees, NCC, '-g');
% exportgraphics(gcf, fullfile(DIR, 'Rotation vs NCC.png'), 'Resolution', 300);

figure(2);
plot(degrees, JE, '-b');
% exportgraphics(gcf, fullfile(DIR, 'Rotation vs JE.png'), 'Resolution'), 300);

figure(3);
plot(degrees, QMI, '-r');
% exportgraphics(gcf, fullfile(DIR, 'Rotation vs QMI.png'), 'Resolution'), 300);

optimal_deg = degrees(JE == min(JE));
J4 = imrotate(J3, optimal_deg, 'crop');
ht = JointHistogram(J1, J4, bin, true);

figure(4);
imagesc(ht);
colorbar;
exportgraphics(gcf, fullfile(DIR, 'Optimal rotation histogram.png'), 'Resolution', 300);
