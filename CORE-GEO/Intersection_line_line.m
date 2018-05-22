function [p e] = Intersection_line_line(PR1_1,PR1_2,PR2_1,PR2_2 )
%%
% [p e] = Intersection_line_line(PR1_1,PR1_2,PR2_1,PR2_2 )
%
% SYNOPSIS: Returns the intersection point between 2 lines in 3d-space.
%           If the lines do not intersect each other, it returns a point in
%           the middle of the nearest points of the lines.
%
% INPUT:    PR1_1:  A point in the first line R1. (3D)
%           PR1_2:  Another point in the first line R1. (3D)
%           PR2_1:  A point in the second line R2. (3D)
%           PR2_2:  Another point in the second line R2. (3D)
%
% OUTPUT:   p: the intersection point between R1 and R2 or lacking that,
%              the point in the middle of the 2 nearest points of the lines
%              R1 and R2. (3D)
%           e: The norm of the instersection error between R1 and R2. e = 0
%              means a real intersection.
%
% REF:             
%           
%
% COMMENTS: e.g: Intersection_line_line([0 -1 1],[3 -1 1],[0 -1 1],[0 -1 3] )

%
% Compute the vector that represents the first line R1 
%
dR1 = [PR1_1 - PR1_2];

%
% Compute the vector that represents the second line R2
%
dR2 = [PR2_1 - PR2_2];

%
% Compute the intersection between R1 and a plane that contains R2,
% perpendicular to R1
%
p1 = Intersection_plane_line(PR1_1,PR1_2,PR2_1,cross(cross(dR1,dR2),dR2));

%
% Compute the intersection between R2 and a plane that contains R1,
% perpendicular to R2
%
p2 = Intersection_plane_line(PR2_1,PR2_2,PR1_1,cross(cross(dR1,dR2),dR1));

%
% Since it is possible that p1 != p2, we compute the intersection, as the
% middle point of p1 and p2
%
p = p1 + (p2-p1)/2;

%
% Computes the norm of the instersection error between R1 and R2.
%
e = norm(p2-p1);