function p_out = Project_point_line(p,PR_1,PR_2,PR1_1,PR1_2,l,c,k,C)
%%
% p_out = Project_point_line(p,PR_1,PR_2,PR1_1,PR1_2,l,c,k,C)
%
% SYNOPSIS: In a given image plane (described by the local reference system
%           l,c,k), centered in C, find the closest point between a given
%           point 'p' (laying in an epipolar described by PR_1, PR_2) and a
%           straight line (usually an epipolar, described by PR1_1 and PR1_2).
%
% INPUT:    p:       2D input point in the image plane.
%           PR_1:    A point of the destination epipolar.
%           PR_2:    Another point of the destination epipolar.
%           PR1_1:   A point of the epipolar containing the point 'p'.
%           PR1_2:   Another point of the epipolar containing the point 'p'.
%           l, c, k: Three vectors describing the local reference system of
%                    the image plane.
%           C:       The CO (Center Plane to Origin) distance of the image
%                    plane.
%           
% OUTPUT:   p_out:   Output point.       
%
% REF: 
%           
% COMMENTS: - All the process is performed in 3D real world coordinates,
%             the final result is backprojected to the image plane.
%           - call example: Project_point_line([0 1],[-2 0],[2 2],[-2 0], ...
%                           [2 0],[0 0 1],[0 -1 0],[-1 0 0],100)
%

%
% Scale factor from X-Ray image pixels to real world mm
%
global sc_fact;

%
% Convert 2D (on image plane points) to 3D real world coordinates
%
C = C*c;

%
% Apply scale factor to all points
%
p     = p     *sc_fact;
PR_1  = PR_1  *sc_fact;
PR_2  = PR_2  *sc_fact;
PR1_1 = PR1_1 *sc_fact;
PR1_2 = PR1_2 *sc_fact;

%
% Convert 2D (on image plane points) to 3D real world coordinates
%
p     = -p(1)    *k + p(2)     *l + C;
PR_1  = -PR_1(1) *k + PR_1(2)  *l + C;
PR_2  = -PR_2(1) *k + PR_2(2)  *l + C;
PR1_1 = -PR1_1(1)*k + PR1_1(2) *l + C;
PR1_2 = -PR1_2(1)*k + PR1_2(2) *l + C;

%
% Compute the vector (direction) that represents the straight line R
%
dirR = [PR_2 - PR_1];

%
% Compute the intersection between line PR1_1 to PR1_2 and the plane
% passing trought 'p' with normal 'dirR'.
%
p_out = Intersection_plane_line(PR1_1,PR1_2,p,dirR );

%
% Project points p back to the X-Ray image plane. This converts from
% 3D point to 2D point in pixels.
%
p_out = ([l; -k]'\ (p_out-C)')' / sc_fact;


