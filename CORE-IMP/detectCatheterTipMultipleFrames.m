function XY = detectCatheterTipMultipleFrames(V)
%%
%
% SYNOPSIS: Detect the most probable point that represent the
%           catheter tip in a series of frames.
%
% INPUT:    V: a set of images (preferably previously ehnanced), V(:,:,1)
%           represent the first image, and so on.
%
% OUTPUT:   XY: a matrix of M (M=size(V,3)) rows and two columns. Each row 
%               indicates the x,y coordinates of the detected point.
%
% REF:
%
%
% COMMENTS: This algorithm is actually based on a blob detector.
%

% visualize = true;
visualize = false;

%% Create a set of N Laplacian filters

N = 8;
%
% The following two parameters MUST be tuned with respect of the expected
% size of the catether tip.
%
base_std = 1;
step_std = 0.5;

for i=1:N
    %
    % Applying the scale-space normalization (see Lindeberg)
    %
    value_std = base_std + step_std * i;
    filters(i).f = fspecial('log', round(7*value_std), value_std)/(2*pi*sqrt(value_std));
    if visualize
        figure, imagesc(filters(i).f);
    end
end

%% Apply the filtering to the input image im_in

%
% Allocate memory for the output images
%
for n_frame=1:size(V,3)
    im_in = V(:,:,n_frame);
    s = size(im_in);
    out_im = zeros(N,s(1),s(2));

    for i=1:N
        out_im(i,:,:) = imfilter(im_in,filters(i).f,'same');
%         if visualize
%             figure, imagesc(squeeze(out_im(i,:,:)));
%         end
    end

    %% Compute the maximum over the scales

    out_max = squeeze(max(out_im,[],1));

    %% Sort the value to find the first Mth local maxima
    [values, linear_indices] = sort(out_max(:),'descend');

    %
    % Select the first Mth maxima
    %
    M = 1; % M can be changed (>1) to have more than one point per image, but its a bit nosense.

    linear_indices = linear_indices(1:M);

    %
    % Convert linear indices to image 2D indices.
    %
    [X,Y] = ind2sub(s,linear_indices);
    XY(n_frame,:) = [X(1) Y(1)];

    if visualize
        figure, imagesc(out_max), axis image;
        hold on, scatter(Y,X,'xr');
        figure, imagesc(im_in), colormap gray, axis image;
        hold on, scatter(Y,X,'xr');
    end
end
