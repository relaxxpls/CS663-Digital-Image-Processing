function outImage = myHistogramEquilization(inImage, windowSize)
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
    %*********************************************************************

    [row, col] = size(inImage);

    % ? add padding of size windowSize to the image
    % * window size = 2 * padding + 1
    windowSize = floor(windowSize / 2);
    inImage = padarray(inImage, windowSize);
    outImage = zeros(size(inImage));

    for i = 1:row

        for j = 1:col
            % imshow(inImage);
            %
        end

    end

    wRow = windowSize(0); wCol = windowSize(1);
    outImage = outImage(wRow + 1:wRow + row, wCol + 1:wCol + col);
    outImage = uint8(outImage);
end
