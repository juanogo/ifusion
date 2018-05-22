function im_out = imageEnhancment(im_in)
%
%
% SYNOPSIS: Enhances the input image by means of local histogram
%           equalization on a 27x27 neighborhood.
%
% INPUT:    im_in:  an image
%
% OUTPUT:   im_out: enhanced image
%
% REF:      - Fusion.pdf - Page 6, Sect 2.1
%           - Fusion.pdf - Page 7, Figure 2.3
%           - Equalization as in "MULTIMODAL REGISTRATION OF INTRAVASCULAR ULTRASOUND IMAGES AND 
%           ANGIOGRAPHY", page 2, formula (1).
%           
%
% COMMENTS: This algorithm can be performed by means of the following
%           (commented) for loop. However, the matlab function nlfilter
%           allows to do it a bit faster.

%%
% % s = size(im_in);
% %
% % im_out = im_in;
% % 
% % for i=14:(s(1)-14)
% %     for j=14:(s(2)-14)
% %         temp_img = im_in((i-13):(i+13),(j-13):(j+13));
% %         a = min(temp_img(:));
% %         b = max(temp_img(:));
% %         im_out(i,j) = (temp_img(14,14) - a)/(b - a);
% %     end
% % end

%%
%   Apply the function 'myHistEq' to the input image im_in in a sliding
%   window way, over a 27x27 neightborhood.
%
im_out = nlfilter(im_in,[27 27],@myHistEq);

function out = myHistEq(region)
%%
% Equalization as in "MULTIMODAL REGISTRATION OF INTRAVASCULAR ULTRASOUND IMAGES AND 
% ANGIOGRAPHY", page 2, formula (1).
%
% Compute minimum and maximum of the region
% 
a = min(region(:));
b = max(region(:));
%
% Apply the equalization
%
out = (region(14,14) - a)/(b - a);

