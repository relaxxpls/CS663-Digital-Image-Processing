function outImage = myHistogramEquilization(inImage, w)
    %*********************************************************************
    %
    % myHistogramEquilization - local histogram equilization
    %
    % Input:
    %   inImage = input image
    %
    % Output:
    %   outImage = output image
    %
    % Notes:
    %   1. Window is assumed to inImagee inImage square of odd size w = 3, 5, 7, ...
    %
    %*********************************************************************

    [m, n] = size(inImage);

    % ? zero padding inImage to avoid boundary overflow problem
    w = floor(w / 2);
    inImage = padarray(inImage, [w, w]);

    outImage = zeros(size(inImage));

    for i = w + 1:w + m

        for j = w + 1:w + n
            cdf = zeros(256, 1);

            for x = -w:w

                for y = -w:w
                    pos = 1 + inImage(i + x, j + y);
                    cdf(pos) = cdf(pos) + 1;
                end

            end

            % ? cumulative distribution function
            for l = 2:256
                cdf(l) = cdf(l) + cdf(l - 1);
            end

            cdf = cdf / (2 * w + 1)^2;

            pos = 1 + inImage(i, j);
            outImage(i, j) = round(255.0 * cdf(pos));
        end

    end

    % ? remove zero padding
    outImage = outImage(w + 1:w + m, w + 1:w + n);
    outImage = uint8(outImage);
end
