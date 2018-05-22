function [Xpath Ypath] = catetherPathFast(im_in,X,Y)
%%
%
% SYNOPSIS: Computes the shortest path of global minimum action from two
%           given points in an image.
%
% INPUT:    im_in:  an image (NOT ehnanced)
%           [X Y]: two vectors of length 2, containing the coordinates of
%           catether ending points.
%
% OUTPUT:   [Xpath Ypath]: two vectors of M elements each that indicates the x,y
%           coordinates of the catether path.
%
% REF:      [1] - L. D. Cohen, R. Kimmel,
%           "Global Minimum for Active Contour Models: A Minimal Path
%           Approach", IJCV 24(1), 57-78 (1997) Kluwer Academic Publishers.
%           
%
% COMMENTS: Both 'steepest gradient descent' and 'gradient descent' have
%           been implemented. The 'steepest gradient descent' is faster and
%           seems more stable. Moreover, the error due to the
%           discretization is not so relevant, since the obtained curve
%           will be approximated by a spline, thus correcting small errors.
%

visualize     = false;  % true;
preprocessing = true;   % false;

%% Compute the potential P, see [1], pag 61, section 3, first sentence.
%
% Assume that the potential P is proportional to the image intensity, this make
% sense since the catether path is dimmer than other structures, so it
% represents a lower potential.
%

if preprocessing
    im_in = imageEnhancment(im_in);
    im_in = imfilter(im_in,fspecial('gaussian',5,1),'same','replicate');
else
    im_in = imfilter(im_in,fspecial('gaussian',5,1),'same','replicate');
end

% figure(10), imshow(im_in); pause;

P = im_in;

%% Compute the surface of minimal action U using the Fast Marching Method,
%  see [1], pag 66, section 4.4
%
%  Initialization:
%

%
% Define constant values for the algorithm
%
far   = 1;
trial = 2;
alive = 3;

%
% Initialize U
%
s = size(P);

U = inf*ones(s);

%
% Initialize the status matrix 'status'
%

status = far*ones(s);

%
% Set the start point to value 0, and label it trial
%

X = uint16(X);
Y = uint16(Y);

U(X(1),Y(1)) = 0;
status(X(1),Y(1)) = trial;

%% Fast Marching Loop
%

%
% Initialize the list of trials, just one element
%

% keyboard

list    = [X(1) Y(1) 0]';
l_count = 1;

run = true;

%
% Actually the loop can stop when we find the target point X(2),Y(2)
% 
%
count = 0;
countdown = -1;
while(run)
    if countdown > 0
        countdown = countdown - 1;
    end
    %
    % Find the 'trial' point with the smallest U value.
    %
    if ~isempty(list)
        [dummy index] = min(list(3,:));
    else
        run = false;
        break;
    end
    
    imin = list(1,index);
    jmin = list(2,index);
    
    %
    % Check if we arrived at the target point.
    % Start a countdown of K iterations to fill in the values
    % of U in the neihgtborhood of X(2),Y(2)
    %
    if ((imin == X(2)) && (jmin == Y(2)))
        countdown = 1000;
    end
    if countdown == 0
        %
        % We arrived at the target point, and filled other 1000 values to
        % assure that close to the target pixel, U is correctly defined.
        % We can stop the fast marching method.
        run = false;
    end
    
    %
    % Label the point as alive, and remove from the trial list.
    %
    status(imin,jmin) = alive;
    list(:,index) = [];
    l_count = l_count - 1;
    
    %
    % For each of the 4 neighboring:
    %
    
    %% up
    i = imin - 1;
    j = jmin;
    
    if (i > 1)
        if (status(i,j) == far)
            status(i,j) = trial;
            
            l_count = l_count + 1;
            list(1,l_count) = i;
            list(2,l_count) = j;
            list(3,l_count) = U(i,j);
        end
        if (status(i,j) ~= alive)
            U(i,j) = solveEq18(U(i-1:i+1,j-1:j+1),P(i,j));
            
            index_ij = intersect(find(list(1,:)==i),find(list(2,:)==j));
            list(3,index_ij) = U(i,j);
        end
    end
    
    %% down
    i = imin + 1;
    j = jmin;
    
    if (i < s(1))
        
        if (status(i,j) == far)
            status(i,j) = trial;
                
            l_count = l_count + 1;
            list(1,l_count) = i;
            list(2,l_count) = j;
            list(3,l_count) = U(i,j);
        end
        if (status(i,j) ~= alive)
            U(i,j) = solveEq18(U(i-1:i+1,j-1:j+1),P(i,j));
            
            index_ij = intersect(find(list(1,:)==i),find(list(2,:)==j));
            list(3,index_ij) = U(i,j);
        end
    end
    
    
    %% left
    i = imin;
    j = jmin - 1;
    
    if (j > 1)
        
        if (status(i,j) == far)
            status(i,j) = trial;
            
            l_count = l_count + 1;
            list(1,l_count) = i;
            list(2,l_count) = j;
            list(3,l_count) = U(i,j);
        end
        if (status(i,j) ~= alive)
            U(i,j) = solveEq18(U(i-1:i+1,j-1:j+1),P(i,j));
            
            index_ij = intersect(find(list(1,:)==i),find(list(2,:)==j));
            list(3,index_ij) = U(i,j);
        end
    end
    
        %% right
    i = imin;
    j = jmin + 1;
    
    if (j < s(2))
        
        if (status(i,j) == far)
            status(i,j) = trial;
            
            l_count = l_count + 1;
            list(1,l_count) = i;
            list(2,l_count) = j;
            list(3,l_count) = U(i,j);
        end
        if (status(i,j) ~= alive)
            U(i,j) = solveEq18(U(i-1:i+1,j-1:j+1),P(i,j));
            
            index_ij = intersect(find(list(1,:)==i),find(list(2,:)==j));
            list(3,index_ij) = U(i,j);
        end
    end
    if visualize
        count = count + 1;
        if (rem(count,100) == 0)
            figure(1), imagesc(U), title('Minimum Action Surface U.'), axis('image');
        end
    end
end

if visualize
    figure(1), imagesc(U), title('Minimum Action Surface U.'), axis('image');
end

%% Perform steepest gradient descent
% 
run = true;
index = 1;

%
% We start from the target point and descend over the surface U
% 
Xpath(index) = X(2);
Ypath(index) = Y(2);
i = X(2);
j = Y(2);

if visualize
    figure(3)
    imshow(im_in);
end

while(run)
    %
    % Find the smallest value in the neighborhood
    %
    neighborhood = U((i-1):(i+1),(j-1):(j+1));

    [dummy ind] = min(neighborhood(:));
    
    [i_rel,j_rel] = ind2sub([3 3],ind);
    i_rel = i_rel - 2;
    j_rel = j_rel - 2;
    
    if ((i_rel == 0) && (j_rel == 0))
        %
        % This means that the minima we're in, it's not the global minimum,
        % i.e. the starting point. This should not happen.
        %
        disp('Critical Error: see the function catetherPathFast.');
        keyboard
        run = false;
        break;
    end

    %
    % Move to the neighborhood pixel that decrease U
    %
    i = i + i_rel;
    j = j + j_rel;

    if ((i == X(1)) && (j == Y(1)))
        %
        % We arrived at the global minimum
        % Stop the next iteration of the steepest gradiend descent
        run = false;
        break;
    end

    %
    % Store the point coordinates in the Xpath, Ypath variables
    %
    index = index + 1;
    Xpath(index) = i;
    Ypath(index) = j;
    
    if visualize
        figure(3), hold on, plot(j,i,'r.');
    end
end

%% Perform gradient descent

% run = true;
% index = 1;
% 
% Xpath(index) = X(2);
% Ypath(index) = Y(2);
% i = X(2);
% j = Y(2);
% 
% if visualize
%     figure(3)
%     imshow(im_in);
% end
% 
% m_step = 0.2;
% 
% %
% % Compute the gradient
% %
% dx = imfilter(U,[-1 1],'same','replicate');
% dy = imfilter(U,[-1 1]','same','replicate');
% 
% 
% % figure(7), imagesc(dx);
% % figure(8), imagesc(dy);
% 
% 
% % dx(1,:) = 0; dx(end,:) = 0; dx(:,1) = 0; dx(:,end) = 0;
% % dy(1,:) = 0; dy(end,:) = 0; dy(:,1) = 0; dy(:,end) = 0;
% 
% % keyboard
% 
% while(run)
%     %
%     % Compute the gradient at (i,j) \in Real
%     % Applying a partial volume interpolation
%     %
%     
%     ci = ceil(i);
%     fi = floor(i);
%     cj = ceil(j);
%     fj = floor(j);
%     
%     A1 = (ci - i)*(cj - j);
%     A2 = (ci - i)*(j - fj);
%     A3 = (i - fi)*(cj - j);
%     A4 = (i - fi)*(j - fj);
%     
%     if ((A1 + A2 + A3 + A4) == 0)
%         dx_l = dx(i,j);
%         dy_l = dy(i,j);
%     else
%         dx_l = dx(fi,fj)*A1 + dx(fi,cj)*A2 + dx(ci,fj)*A3 + dx(ci,cj)*A4;
%         dy_l = dy(fi,fj)*A1 + dy(fi,cj)*A2 + dy(ci,fj)*A3 + dy(ci,cj)*A4;
%     end
%     
%     % Normalize the gradient vector
%     
%     if isinf(dx_l) || (isnan(dx_l))
%         dx_l = 0;
%         % keyboard
%     end
%     if isinf(dy_l) || (isnan(dy_l))
%         dy_l = 0;
%         % keyboard
%     end
%     
%     norm_l = sqrt(dx_l^2 + dy_l^2);
%     
%     if (norm_l < 0.00001)
%         run = false;
%         % keyboard
%         % break;
%     end
%     
%     dx_l = dx_l/norm_l;
%     dy_l = dy_l/norm_l;
%     
%     i = i - m_step*dy_l;
%     j = j - m_step*dx_l;
%     
%     %
%     % Distance to end point
%     %
%     
%     dist_to_end_point = sqrt((i - X(1))^2 + (j - Y(1))^2);
%     
%     if (dist_to_end_point < 1)
%         run = false;
%         % break;
%     end
% 
%     index = index + 1;
%     Xpath(index) = i;
%     Ypath(index) = j;
%     
%     if visualize
%         figure(3), hold on, plot(j,i,'r.');
%     end
%     % index
% 
% end

Xpath(index + 1) = X(1);
Ypath(index + 1) = Y(1);
