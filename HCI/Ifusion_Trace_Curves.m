function Ifusion_Trace_Curves (axes_left, axes_right, axes_selected, curve, extreme, x , y)
%
% Ifusion_Trace_Curves (axes_left, axes_right, axes_selected, curve, extreme, x , y)
%
% SYNOPSIS: This function manages the curves visualization when changing from
%           one angiography frame to another, and when moving between
%           BeforePullback and AfterBullback (using buttons in Ifusion_interface_2.m).
%
% INPUT:    axes_left:      the handle of the left axes in the
%                           interface_2.m
%
%           axes_right:     the handle of the right axes in the
%                           interface_2.m
%
%           axes_selected:  the handle of the selected axes.
%
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
%           extrem:         variable that can assume two values:
%                           - 1: the list of points represent 'extremes'.
%                           - 2: the list of points represent 'tips'.
%
%           x,y:            x,y coordinates of the point where user
%                           clicked.
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
% If the selected axes is the left one
%
if isequal(axes_selected, axes_left)
    %
    % set the non-selected axes to right
    %
    axes_noselected = axes_right;
    curve = 1;
else
    %
    % set the non-selected axes to left
    %
    axes_noselected = axes_left;
    curve = 2;
end

%
% Set axes size, and make them visible.
%
set(axes_left,'XLim',[0 im_size]);
set(axes_left,'YLim',[0 im_size]);
set(axes_left,'Visible','on');

set(axes_right,'XLim',[0 im_size]);
set(axes_right,'YLim',[0 im_size]);
set(axes_right,'Visible','on');

%
% If there is an epipolar line
%
if ishandle(Epi)
    %
    % delete it.
    %
    delete(Epi)
end

%
% If the function is called with just the two axes handlers and the handler
% of selected axes; and the curves already exist.
%
if nargin == 3 && ~isempty(Curves{1}.coor)
    %
    % Just manage graphical objects (as Epipolar line and curve) in the selected axes. 
    %
    child = get(axes_selected,'Children');
    
    if size(Curves{1}.control_pts,1)==0
        if ~isequal(child(1),Curves{curve}.pointer)
            set(axes_selected,'Children',[Curves{curve}.pointer ;child]);
            delete(child(3:end))
        end
    else
        if curve==1
            for i=1:size(Curves{1}.control_pts,2)
                ch=get(Curves{1}.control_pts{i},'Children');
                new_child(i)=get(ch(1),'Parent');
            end
        else
            for i=1:size(Curves{2}.control_pts,2)
                ch=get(Curves{2}.control_pts{i},'Children');
                new_child(i)=get(ch(1),'Parent');
            end
        end
        new_child=[new_child Curves{curve}.pointer];
        set(axes_selected,'Children',[new_child' ;child]);
        delete(new_child(8:end))
    end
end

%
% If a candidate tip or extreme is provided, add it and refresh the
% visualization. This function is usually not called, since the 'tip' and
% 'extreme' candidates are selected automatically.
%
if nargin == 7 
    Curves{curve}.coor(extreme,:) = [y x];
    
    axes(axes_selected)
    
    if ~isempty(Curves{curve}.pointer)
        set(Curves{curve}.pointer,'Visible','off')
    end
    
    hold on
    Curves{curve}.pointer=plot(Curves{curve}.coor(:,2),Curves{curve}.coor(:,1),'*r');
    hold off
end


