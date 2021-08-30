function out_image = NearestNeighborInterpolation(in_image, T)
    [M, N] = size(in_image);
    out_image = zeros(M, N);

    for r = 1:M

        for c = 1:N

            J = pinv(T) * [r; c; 1];
            x = round(J(1, 1));
            y = round(J(2, 1));

            if x > 0 && y > 0 && x <= M && y <= N
                out_image(r, c) = in_image(x, y);
            end

        end

    end

end
