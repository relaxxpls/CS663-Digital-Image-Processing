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
bin = 10;

d_n = length(degrees);
QMI = zeros(d_n, 1);
JE = zeros(d_n, 1);

for idx = 1:d_n
    deg = degrees(idx);
    
    J4 = imrotate(J3, deg, 'crop');

    NCC = normxcorr2(J3, J4);

    I1 = J4(:);
    I2 = J1(:);

    % joint histogram of J1 & J4
    min1 = min(I1); max1 = max(I1);
    min2 = min(I2); max2 = max(I2);
    N1 = 1 + (max1 - min1) / bin;
    N2 = 1 + (max2 - min2) / bin;

    ht = zeros(N1, N2);
    for pos = 1:m*n
        x1 = 1 + (I1(pos) - min1) / bin;
        x2 = 1 + (I2(pos) - min2) / bin;
        ht(x1, x2) = ht(x1, x2) + 1;
    end

    ht = ht / (m * n); % normalization

    xm = sum(ht, 2); xm = xm(:);
    ym = sum(ht, 1); ym = ym(:);

    for r = 1:N1
        for c = 1:N2
            % Joint entropy
            if ht(r, c) > 0
                JE(idx) = JE(idx) - ht(r, c) * log2(ht(r, c));
            end

            % quadratic mutual information
            QMI(idx) = QMI(idx) + (ht(r, c) - ym(r) * xm(c)).^2;
        end
    end

    % cause ym or xm can have 0s thus log is undefined
    % thus we use xm + (xm == 0) 

    % JE = -1 * sum(ym .* log2(ym + (ym == 0)));
end

figure(1)
plot(degrees, JE, '-b')
exportgraphics(gcf, 'report/Rotation vs JE.png', 'Resolution', 300)

figure(2)
plot(degrees, QMI, '-g')
exportgraphics(gcf, 'report/Rotation vs QMI.png', 'Resolution', 300)
