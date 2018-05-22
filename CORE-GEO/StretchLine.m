function lout = StretchLine( line, rect )
%%
% lout = StretchLine( line, rect )
%
% SYNOPSIS: This function works only in 2D geometry. Given a rectangle
%           'rect', and a line 'line', the function returns the input
%           straight line cropped in the given rectangular bound.
%
% INPUT:    line: a 2x2 matrix, each row is a 2D point.
%           rect: a 1x4 matrix, given upper-left corner (rect(1),rect(2))
%                 and lower-right corner (rect(3),rect(4))
%           
% OUTPUT:   lout: the cropped output line in a 2x2 matrix, each row is a 2D
%                 point.
%
% REF: 
%           
% COMMENTS: 
%

%
% Check if the input line is vertical.
%
if (line(1,1) == line(2,1))
    %
    % In this special case, the output can be computed as follows:
    %
	lout = [ line(1,1) rect(2) ; line(1,1) rect(4) ]; 
    return
end

%
% Check if the input line is horizontal.
%
if (line(1,2) == line(2,2))
    %
    % In this special case, the output can be computed as follows:
    %
	lout = [ line(1,2) rect(1) ; line(1,2) rect(3) ]; 
    return
end

%
% In the general case, we compute the parameters 'm' and 'b' of the
% straight line equation y = m * x + b 
%

vx = line(2,1) - line(1,1);
vy = line(2,2) - line(1,2);

m = vy/vx;
b = line(1,2) - m*line(1,1);

%
% Compute the intersection of the straight line y = m*x + b with the
% bounding rectangle (left side).
%
p3x = rect(1);
p3y = m*p3x + b;

%
% Check if the intersection is outside the rectangle, and if this is the
% case, fix it properly.
%
if (p3y < rect(2))
	p3y = rect(2);
	p3x = (p3y - b)/m;
else 
    if (p3y > rect(4))
		p3y = rect(4);
		p3x = (p3y - b)/m;
    end
end

%
% Compute the intersection of the straight line y = m*x + b with the
% bounding rectangle (right side).
%
p4x = rect(3);
p4y = m*p4x + b;

%
% Check if the intersection is outside the rectangle, and if this is the
% case, fix it properly.
%
if (p4y < rect(2))
	p4y = rect(2);
	p4x = (p4y - b)/m;
else 
    if (p4y > rect(4))
		p4y = rect(4);
		p4x = (p4y - b)/m;
    end
end

%
% Return the cropped line
%
lout = [ p3x p3y ; p4x p4y];