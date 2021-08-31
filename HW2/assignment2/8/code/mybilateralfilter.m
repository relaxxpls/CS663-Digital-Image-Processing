function outputImage = myBilateralFilter(inputImage, sigma_s, sigma_r, w = 5)
    % ? Input:
    % * inputImage: the input image
    % * sigma_s: the spatial standard deviation
    % * sigma_r: the range standard deviation
    % * w: the window size

    % ? Output:
    % * outputImage: The filtered image.

    [row, col] = size(inputImage);
    outputImage = zeros(row, col);

    gaus = exp(-(X.^2 + Y.^2) / (2 * sigma_s^2));

    for i = 1:row

        for j = 1:col
            % get the window (handle the overflow)
            window = inputImage(max(i - w, 1):min(i + w, row), max(j - w):min(j + w, col));

            scaledWindow = (exp(-1 * (window - inputImage(i, j)).^2 / (2 * sigma_r^2))) .* gaus((max(i - w, 1):min(i + w, row)) - i + w + 1, (max(j - w, 1):min(j + w, col)) - j + w + 1);

            outputImage(i, j) = sum(scaledWindow(:) .* window(:)) / sum(scaledWindow(:));

            % [X, Y] = meshgrid(-windowSize:windowSize, -windowSize:windowSize);
            % outputImage(i, j) = exp(-1 * (inputImage(i, j) - inputImage(window)).^2 / (2 * sigma_r^2)) * exp(-1 * (window - inputImage(i, j)).^2 / (2 * sigma_s^2)) / weight;
        end

    end

end
