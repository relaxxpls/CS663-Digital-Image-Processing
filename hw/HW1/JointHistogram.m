function ht = JointHistogram(I1, I2, bin, normalize)
    % convert to linear array
    assert(isequal(size(I1), size(I2)));
    [m, n] = size(I1);

    I1 = double(I1(:));
    min1 = min(I1);
    max1 = max(I1);

    I2 = double(I2(:));
    min2 = min(I2);
    max2 = max(I2);

    N1 = 1 + uint8(max1 - min1) / bin;
    N2 = 1 + uint8(max2 - min2) / bin;

    ht = zeros(N1, N2);

    for pos = 1:m * n
        x1 = 1 + uint8(I1(pos) - min1) / bin;
        x2 = 1 + uint8(I2(pos) - min2) / bin;
        ht(x1, x2) = ht(x1, x2) + 1;
    end

    % normalization
    if normalize
        ht = ht / (m * n);
    end

end
