function [segmented_img] = myMeanShiftSegmentation(img, h_spatial, h_intensity, num_neighbours, max_iter)

    img = im2double(img);
    segmented_img = img;

    [rows, columns] = size(img);
    features = zeros(rows * columns, 3);

    for i = 1:rows

        for j = 1:columns
            features((i - 1) * columns + j, :) = [i / h_spatial, j / h_spatial, img(i, j) / h_intensity];
        end

    end

    for num_iter = 1:max_iter

        [nearest_neigh, distances] = knnsearch(features, features, 'k', num_neighbours);
        temp_features = features;

        for i = 1:rows * columns
            weights = exp(-(distances(i, :).^2) / 2);
            sum_weights = sum(weights);
            weights = weights';
            features(i, 3) = sum(weights .* temp_features(nearest_neigh(i, :), 3)) / sum_weights;
        end

    end

    for i = 1:rows

        for j = 1:columns
            segmented_img(i, j) = features((i - 1) * columns + j, 3);
        end

    end

end
