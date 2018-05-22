function ep = Epipolar(p,FP,F,CP,C,l,c,k,lP,cP,kP)
%%
% ep = Epipolar(p,FP,F,CP,C,l,c,k,lP,cP,kP)
%
% SYNOPSIS: Calculates the epipolar line in a plane (P), caused by a
%           projected point (p) from other plane
%
% INPUT:    p:     point (2D)
%           FP:    distance from the epipolar-plane's focus to the origin
%           F:     distance from the point-plane's focus to the origin
%           CP:    distance from the epipolar-plane's center to the origin
%           C:     distance from the point-plane's center to the origin
%           l:     l vector of the point-plane (3D)
%           k:     k vector of the point-plane (3D)
%           c:     c vector of the point-plane (3D)
%           lP:    l vector of the epipolar-plane (3D)
%           kP:    k vector of the epipolar-plane (3D)
%           cP:    c vector of the epipolar-plane (3D)
%
% OUTPUT:   ep:    A 2x2 matrix where each row represents a 2D point over
%                  the epipolar-plane belonging to the epipolar line
%
% REF:             
%           
% COMMENTS: e.g: Epipolar([0 0],3,3,10,10,[0 0 1],[-1 0 0],[0 -1 0],[0 0 1],[0 -1 0],[1 0 0])

%%

%
% Scale factor from X-Ray image pixels to real world mm
%
global sc_fact; % [mm/pixel]

%
% Convert 2D (on image plane points) to 3D real world coordinates
%
Cp = C*c;   % 3D Center of plane on which the epipolar line will be plot
CP = CP*cP; % 3D Center of the point on the other X-Ray image plane

%
% Apply scale factor to point 'p' (the point that generates the epipolar)
%
p = p*sc_fact;

%
% Convert 2D (on image plane points) to 3D real world coordinates
%
p = -k*p(1) + p(2)*l + Cp;

%
% Convert 2D (on image plane points) to 3D real world coordinates
%
F  = -F*c;   % 3D Focus of the projected point plane
FP = -FP*cP; % 3D Focus of the holder epipolar plane

%
% Compute the intersection point between the line (FP->p) and the epipolar holder plane 
%
p2 = Intersection_plane_line(FP,p,CP,cP);

%
% Intersection point between the line (F->FP) and the epipolar holder plane
%
p3 = Intersection_plane_line(F,FP,CP,cP);

%
% Project points p2 and p3 back to the X-Ray image plane (i.e. epipolar
% holder plane). This converts from 3D points to 2D points in mm.
%
p2=([lP; -kP]'\ (p2-CP)')';
p3=([lP; -kP]'\ (p3-CP)')';

%
% The resulting epipolar line is returned in pixels, simply dividing by the
% scale factor.
%
ep = [p2; p3] / sc_fact;



 