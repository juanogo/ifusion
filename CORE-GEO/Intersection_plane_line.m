function p = Intersection_plane_line(PR_1,PR_2,PP_1,PP_N)
%%
% p = Intersection_plane_line(PR_1,PR_2,PP_1,PP_N)
%
% SYNOPSIS: Calculates the 3D point intersection between a plane and a line
%
% INPUT:    PR_1:  First line's point (3D)
%           PR_2:  Second line's point (3D)
%           PP_1:  A point over the plane (3D)
%           PP_N:  A vector orthogonal to the plane (3D)
%
% OUTPUT:   p:  3D vector that represents the intersection point
%           
%
% REF:      Any basic 3D geometry book.
%           
%
% COMMENTS: 

%%

%
% Compute the vector that represents the line 
% 
PR_2 = [PR_2 - PR_1];

%
% Solve the parameters a, b, c and d for the plane equation ax + by + cz + d = 0
%
a = PP_N(1);
b = PP_N(2);
c = PP_N(3); 

d = - a*PP_1(1) - b*PP_1(2) - c*PP_1(3);

%
% Having the straight line as a parametrized function (x(t), y(t) and z(t)),
% find the intersection with the given plane, in terms of the parameter 't'.
%

t = (-d - a*PR_1(1) - b*PR_1(2) - c*PR_1(3))/ ...
    ( a*PR_2(1)     + b*PR_2(2) + c*PR_2(3)); 

%
% Compute the value on the straight line at the parameter 't', i.e. the
% intersection we are searching for.
%
p = [PR_1(1) + PR_2(1)*t ...
     PR_1(2) + PR_2(2)*t ...
     PR_1(3) + PR_2(3)*t ];
