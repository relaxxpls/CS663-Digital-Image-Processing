function outImage = mybilateralfilter(inImage, sigma_s, sigma_r, w)
    %*********************************************************************
    %
    % ? mybilateralfilter: Performs bilateral filtering on the input image
    %
    % ? Input:
    % * inImage:    Input image.
    % * sigma_s:    Gaussian spatial sigma.
    % * sigma_r:    Gaussian range sigma.
    % * w:          Window size.
    %
    % ? Output:
    % * outImage: Filtered image.
    %
    %*********************************************************************

    [m, n] = size(inImage);

    % ? zero padding inImage to avoid boundary overflow problem
    inImage = padarray(inImage, [w, w]);
    inImage = double(inImage);

    outImage = zeros(size(inImage));

    [x, y] = meshgrid(-w:w, -w:w);

    % ? gaussian filter based on distance to the center pixel (sigma_s)
    wd = exp(-(x.^2 + y.^2) / (2 * sigma_s^2));

    for i = w + 1:w + m

        for j = w + 1:w + n
            % ? gaussian filter based on range of surrounding pixels (sigma_r)
            wr = exp(-((inImage(i - w:i + w, j - w:j + w) - inImage(i, j)).^2) / (2 * sigma_r^2));

            % ? net weight
            wb = wd .* wr;

            % ? weighted average
            s = inImage(i - w:i + w, j - w:j + w) .* wb;
            outImage(i, j) = sum(s(:)) / sum(wb(:));
        end

    end

    % ? remove zero padding
    outImage = outImage(w + 1:w + m, w + 1:w + n);
    outImage = uint8(outImage);
end
