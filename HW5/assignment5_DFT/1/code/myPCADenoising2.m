function outImage = myPCADenoising2(inImage, sigma)
    [m, n] = size(inImage);
    outImage = double(zeros(m, n));
    outMask = double(zeros(m, n));

    % ? Patch size
    knn = 200;
    p = 7;
    neighbour = 31;
    N = (neighbour + 1 - p) * (neighbour + 1 - p);

    for i = 1:m +1 - neighbour

        for j = 1:n +1 - neighbour
            subImage = inImage(i:i - 1 + neighbour, j:j - 1 + neighbour);
            P = zeros(p * p, N);

            for ii = 1:neighbour + 1 - p

                for jj = 1:neighbour + 1 - p
                    patch = subImage(ii:ii - 1 + p, jj:jj - 1 + p);
                    P(:, (ii - 1) * (neighbour + 1 - p) + jj) = patch(:);
                end

            end

            [IDX, D] = knnsearch(P', P(:, 1)', 'K', knn);
            Qi = P(:, IDX);
            Qit = Qi * Qi';
            [W, T] = eig(Qit);

            alpha_ij = W' * Qi;
            alpha_j = max(0, sum(alpha_ij.^2, 2) / N - sigma^2);

            alphaDenoised = alpha_ij ./ (1 + (sigma * sigma) ./ kron(alpha_j, ones(1, knn)));
            denoisedPatches = W * alphaDenoised;

            outImage(i:i + p - 1, j:j + p - 1) = outImage(i:i + p - 1, j:j + p - 1) + reshape(denoisedPatches(:, 1), p, p);
            outMask(i:i + p - 1, j:j + p - 1) = outMask(i:i + p - 1, j:j + p - 1) + 1;
        end

    end

    outImage = outImage ./ outMask;

    outImage = outImage(1:m + 1 - neighbour, 1:n + 1 - neighbour);
    outImage = uint8(outImage);
end
