function segmented_img = myMeanShiftSegmentation(img, hs, hr)

    % create feature vectors
    Q = []; % list of feature vectors
    [h, w] = size(img);

    for i = 1:h

        for j = 1:w
            q = [i, j, img(i, j)];
            Q = [Q; q];
        end

    end

    Q = single(Q);

    %     hs = 2;
    %     hr = 2;

    s = size(Q);

    segmented_img = img;

    for i = 1:s(1)
        y0 = Q(i, :);
        shift = 999;
        y1 = y0;

        while shift > 1

            n = 3; % neighborhood
            N = 0; % numerator
            D = 0; % Denominator
            s = size(Q);

            for i = 1:s(1)
                q = Q(i, :);
                x = [q(1), q(2)];
                ys = [y1(1), y1(2)];

                if norm(x - ys) <= n
                    I = double(q(3));
                    yI = double(y1(3));
                    N = N + q * exp(-norm(x - ys)^2 / (2 * hs^2)) * exp(-norm(I - yI)^2 / (2 * hr^2));
                    D = D + exp(-norm(x - ys)^2 / (2 * hs^2)) * exp(-norm(I - yI)^2 / (2 * hr^2));
                end

            end

            y2 = N / D;

            % shift = norm(y2 - y1);
            shift = shift - 10;
            y1 = y2;
            %         disp('yey')
        end

        segmented_img(y0(1), y0(2)) = y2(3);
    end

end
