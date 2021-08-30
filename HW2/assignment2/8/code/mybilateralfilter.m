function output = myFun(input)
    % myBilateralFilter - Applies Bilateral filter on the noisy image
    %
    % Syntax: output = myFun(input)

end

% helper code
% function myBilateralFilter(img, name)

%     if (name == 'grass')
%         grass(img);
%         sigma_s = 0.8;
%         count = 16;
%     elseif (name == 'honey')
%         honey(img);
%         sigma_s = 0.95;
%         count = 18;
%     else
%         barbara(img);
%         sigma_s = 0.9;
%         count = 17;
%     end

%     [X, Y] = meshgrid(-5:5, -5:5);
%     G_space = exp(-(X.^2 + Y.^2) / (2 * sigma_s^2));
%     imwrite(G_space(1:2 * 5 + 1, 1:2 * 5 + 1), "../images/Spatial_gaussian$" + sigma_s + ".png")
%     figure(count)
%     imagesc(G_space(1:2 * 5 + 1, 1:2 * 5 + 1));
%     colormap(gray);
%     colorbar
%     axis on
%     title("Spatial Gaussian for \sigma_s = " + sigma_s)

% end
