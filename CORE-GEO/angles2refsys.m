function [l k c] = angles2refsys(alpha,beta)
%%
% [l k c] = angles2refsys(alpha,beta)
%
% SYNOPSIS: Computes the local reference system (l, k and c) of the X-Ray
%           plane image in 3D real coordinates as in [1] given the primary
%           and secondary angles of the CArm systems.
%
% INPUT:    alpha:   Primary angle of the CArm system, for a particular
%                    X-Ray projection (i.e. X-Ray image plane).
%           beta:    Secondary angle of the CArm system, for a particular
%                    X-Ray projection (i.e. X-Ray image plane).
%           
% OUTPUT:   l:       Vertical axis of the X-Ray image plane.
%           k:       Horizontal axis of the X-Ray image plane.
%           c:       Axis orthogonal to both 'l' and 'k'. This axis
%                    points in the opposite direction with respect to
%                    the origin of real world global reference system. 
%
% REF:      [1] A. C. M. Dumay, J. H. C. Reiber and J. J. Gerbrands,
%               "Determination of optimal angiographic vieweing angles:
%               basic principles and evaluation study", IEEE TMI, 13(1),
%               pp 13-24 (1994).
%           
% COMMENTS: Figures 3 and 4 in the paper [1] could help to understand the
%           local and global reference systems. 
%

%
% Compute the vectors (k,l,c) as in the paper [1], equations (1), (2)
% and (4), page 15.
%
k = [0          -cos(alpha)             sin(alpha)              ];
c = [sin(beta)  sin(alpha)*cos(beta)    cos(alpha)*cos(beta)    ];
l = [cos(beta)  -sin(alpha)*sin(beta)   -cos(alpha)*sin(beta)   ];