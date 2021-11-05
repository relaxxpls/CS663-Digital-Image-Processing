function outImage = myPCADenoising1(inImage, sigma)
    [m, n] = size(inImage);
    outImage = double(zeros(m, n));

    % ? Patch size
    p = 7;
    N = (m + 1 - p) * (n + 1 - p);
    P = zeros(p * p, N);

    for i = 1:m + 1 - p

        for j = 1:n + 1 - p
            patch = inImage(i:i + p - 1, j:j + p - 1);
            P(:, (i - 1) * (n + 1 - p) + j) = patch(:);
        end

    end

    Pt = P * P';
    [V, D] = eig(Pt);
    alpha_ij = V' * P;
    alpha_j = max(0, sum(alpha_ij.^2, 2) / N - sigma^2);
    alphaDenoised = alpha_ij ./ (1 + (sigma * sigma) ./ kron(alpha_j, ones(1, N)));

    denoisedPatches = V * alphaDenoised;

    factor = double(zeros(m, n));

    for i = 1:m + 1 - p

        for j = 1:n + 1 - p
            outImage(i:i + p - 1, j:j + p - 1) = outImage(i:i + p - 1, j:j + p - 1) + reshape(denoisedPatches(:, (n + 1 - p) * (i - 1) + j), p, p);
            factor(i:i + p - 1, j:j + p - 1) = factor(i:i + p - 1, j:j + p - 1) + 1;
        end

    end

    outImage = outImage ./ factor;
    outImage = uint8(outImage);
end
