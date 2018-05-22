function angles = calcular_angulos(u,v)
%%
% angles = calcular_angulos(u,v)
%
% SYNOPSIS: Given a set of 2D vectors, in the Cartesian form (u,v), the
%           function returns the angles of the respective polar form.
%
% INPUT:    u:   Horizontal coordinate of the 2D vector.
%           v:   Vertical coordinate of the 2D vector.
%           
% OUTPUT:   angles: Angles of every vector (u,v), obtained by the
%                   respective polar form. 
%
% REF: 
%           
% COMMENTS: - 'u' and 'v' could be a matrix.
%           - This function is used for visualization of IVUS longitudinal
%             cuts only. Temporarily unused.
%

%
% For all the input vectors
%
for ii=1:size(u,1)
     for jj=1:size(u,2)
         %
         % Extract Cartesian coordinates.
         %
         x = u(ii,jj);
         y = v(ii,jj);
         
         %
         % Manage all possible cases of atan (this could be done by
         % atan2 MATLAB function)
         %
         if (x<0 && y>0)||(x<0 && y<0)
           angles(ii,jj) = 180 + rad2deg(atan(y/x));
         elseif x==0 && y>0
           angles(ii,jj) = 90;
         elseif x==0 && y<0
           angles(ii,jj) = 270;
         elseif x==0 && y==0
           angles(ii,jj) = 0;
         elseif x>0 && y<0
           angles(ii,jj) = 360 + rad2deg(atan(y/x));
         else
           angles(ii,jj) = rad2deg(atan(y/x)); 
         end
     end
   end