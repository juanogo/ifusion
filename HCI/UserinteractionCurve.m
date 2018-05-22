function UserinteractionCurve(axes_left,axes_right,axes_selected,curve,api)
%
% UserinteractionCurve(axes_left,axes_right,axes_selected,curve,api)
%
% SYNOPSIS: This function manages the postition and movement of the 2D
%           control points that influences the 2D model curve shape. This
%           function is linked to the callback of the 'impoint' class used
%           in interface_2.m. Each time a control points is moved, this
%           function is automatically called. It is important to note, that
%           changing the position of a control point changes both
%           curves (Left and Right). This process is managed in this code.
%
% INPUT:    axes_left:      the handles of the left axes in the
%                           interface_2.m
%           axes_right:     the handles of the right axes in the
%                           interface_2.m
%           axes_selected:  the handles of the axes that contains the curve
%                           containing the control point that has been
%                           moved.
%           curve:          This can assume only two integer values:
%                           - 1: the curve that has been modified is the
%                                left one.
%                           - 2: the curve that has been modified is the
%                                right one.
%                           Since it is very useful to pass from the left
%                           to right curves and vice-versa, every time we
%                           need to do this, we apply the formula 3-curve.
%                           So that, we have two cases:
%                           - if curve = 1 then (3-curve) = 2
%                           - if curve = 2 then (3-curve) = 1
%                           The notation (3-curve) is a very short way to
%                           refer to the 'other' curve.
%
%           api:            A cell array structure containing the api of
%                           the 5 control points of the curve 'curve'.
%
% OUTPUT:   None. It modifies global variables that describes the 2D and 3D
%           models.
%
% REF:      
%
% COMMENTS:
%

%
% Access to global variables
%
Ifusion_Global
%
%% INTERPOLATE CURRENT CURVE
%

%
% Initialize empty vectors representing the position of the control points
% xt, yt.
%
xt = [];
yt = [];

%
% Initialize empty temporary vector v.
%
v  = [];

for i=1:length(api)
    %
    % Read the current coordinates of the i_th api
    %
    v = api{i}.getPosition();
    
    %
    % Copy it in the xt, yt vectors
    %
    xt(i) = v(1);
    yt(i) = v(2);
end

%
% Set the parameter 't' with linear increasing integer elements from 0 to
% size(xt,2) in steps of 1.
% 
t  = linspace(0,1,size(xt,2));

%
% Set the parameter 'tt' with linear increasing integer elements from 0 to
% size(Curves{curve}.coor,1), i.e. the size of the real curve. Notice that
% Curves is a global variable!
% 
tt = linspace(0,1,size(Curves{curve}.coor,1));

%
% Since one of the control points has been moved, we interpolate the new
% curve by means of two splines, using the new positions of control points.
%
Curves{curve}.coor(:,2) = spline(t,xt,tt);
Curves{curve}.coor(:,1) = spline(t,yt,tt);

%
%% FIND THE CONTROL POINT BEING MOVED and 
%  UPDATE POSITION OF PAIRED CTRL POINT ON OTHER CURVE
%

%
% For all the control points that belong to the current (the just moved
% one) curve, we want to update the position of the control points of the
% 'other' curve.
%
for id = 1:length(api)
    %
    % If the current control point has been moved, i.e. its current
    % position is different (~isequal) than the old one (that is stored in
    % 'Curves{curve}.old_curve', we desire to recompute the position of the
    % corresponding control point on the 'other' curve.
    %
    if ~isequal(Curves{curve}.old_curve(id,:),Curves{curve}.control_pts{id}.getPosition())
        %
        % Generate the epipolar of moved control point at its 'old'
        % position. To understand this call, please refer to the comments
        % of function 'Epipolar'.
        %
        epi_old = Epipolar(Curves{curve}.old_curve(id,:) - round(im_size/2), ...
                           F(3-curve),   F(curve),   C(3-curve), C(curve), ...
                           l(curve,:),   c(curve,:), k(curve,:), l(3-curve,:), ...
                           c(3-curve,:), k(3-curve,:));
        %
        % Generate the epipolar of moved control point at its CURRENT
        % position. To understand this call, please refer to the comments
        % of function 'Epipolar'.
        %                       
        epi_new = Epipolar(Curves{curve}.control_pts{id}.getPosition() - round(im_size/2), ...
                           F(3-curve),   F(curve),   C(3-curve), C(curve), ...
                           l(curve,:),   c(curve,:), k(curve,:), l(3-curve,:), ...
                           c(3-curve,:), k(3-curve,:));
        %
        % Computes the position of the control point in the 'other' curve
        % that is linked to the current control point in THIS curve. This
        % is done by moving the 'other' curve control point to the closest
        % point of the new epipolar line.
        %
        v = Project_point_line(Curves{3-curve}.control_pts{id}.getPosition() - round(im_size/2), ...
                               epi_old(1,end:-1:1), epi_old(2,end:-1:1), ...
                               epi_new(1,end:-1:1), epi_new(2,end:-1:1), ...
                               l(3-curve,:),        c(3-curve,:), ...
                               k(3-curve,:),        C(3-curve));
        xt(id) = v(2) + round(im_size/2);
        yt(id) = v(1) + round(im_size/2);
        
        %
        % As we have to move the control point on the 'other' curve we
        % don't want it to call this function again. To avoid this, we
        % simply remove the callback (that points to this function) from
        % the control point on the 'other' curve.
        %
        Curves{3-curve}.api{id}.removeNewPositionCallback(Curves{3-curve}.id_fun{id});
        %
        % Then, we can change the control point position safely.
        %
        Curves{3-curve}.control_pts{id}.setPosition([(v(2) + round(im_size/2)) (v(1) + round(im_size/2))]);
        %
        % We set back the link of the callback to this function. Actually
        % we undo what we did at line 143.
        %
        Curves{3-curve}.id_fun{id} = Curves{3-curve}.api{id}.addNewPositionCallback(@(p)UserinteractionCurve(axes_left, axes_right,axes_selected,3-curve,Curves{3-curve}.api));
    else
        %
        % If the i_th control point has not been moved, we keep it
        % unalterated, and store it in xt and yt, with the aim to
        % interpolate it later.
        %
        v = Curves{3-curve}.control_pts{id}.getPosition();
        xt(id) = v(1);
        yt(id) = v(2);
    end
end
%
%% INTERPOLATE THE OTHER CURVE
%

%
% Set the parameter 'tt' with linear increasing integer elements from 0 to
% size(Curves{3-curve}.coor,1) in steps of 1.
% 
tt=linspace(0,1,size(Curves{3-curve}.coor,1));

%
% We interpolate the new 'other' curve by means of two splines,
% using the new positions of control points.
%
Curves{3-curve}.coor(:,2) = spline(t,xt,tt);
Curves{3-curve}.coor(:,1) = spline(t,yt,tt);


%
%% PLOT BOTH UPDATED CURVES
%

%
% Update the visualization of both curves
%
set(Curves{1}.pointer,'Visible','off');
axes(axes_left)
hold on
Curves{1}.pointer = plot(Curves{1}.coor(:,2), Curves{1}.coor(:,1), 'y');
set(Curves{1}.pointer,'HitTest','off');
hold off

set(Curves{2}.pointer,'Visible','off');
axes(axes_right)
hold on
Curves{2}.pointer = plot(Curves{2}.coor(:,2), Curves{2}.coor(:,1), 'y');
set(Curves{2}.pointer,'HitTest','off');
hold off

%
% Store the curve in the old_curve structure
%
for id=1:length(api)
    Curves{2}.old_curve(id,:) = [Curves{2}.control_pts{id}.getPosition()];
    Curves{1}.old_curve(id,:) = [Curves{1}.control_pts{id}.getPosition()];
end
