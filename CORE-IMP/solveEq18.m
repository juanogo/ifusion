function u = solveEq18(U,Pij)
%%
%
% SYNOPSIS: Solves Eq. 18 of the paper "Global Minimum for Active Contour
%           Models: A Minimal Path Approach". This function is used ONLY by
%           the 'catetherPathFast.m' function.
%
% INPUT:    U:   the surface of minimal action 'U' 
%           Pij: the value of potential 'P' at location i,j. Actually P(i,j); 
%
% OUTPUT:   u:   the value solving eq. 18.
%
% REF:      [1] - L. D. Cohen, R. Kimmel,
%           "Global Minimum for Active Contour Models: A Minimal Path
%           Approach", IJCV 24(1), 57-78 (1997) Kluwer Academic Publishers.
%           
% COMMENTS: In the paper there are no hint on how to solve the equation,
%           that is highly non-linear. We found a closed form to quickly solve it.
%

%
% Compute pij2
%
Pij2 = Pij^2;

%
% Compute a and b, as following:
% 
% a = min(U_{i-1,j},U_{i+1,j})
% b = min(U_{i,j-1},U_{i,j+1})
%
% This part helps to solve eq. 18 easily
%
a = min([U(2,1) U(2,3)]);
b = min([U(1,2) U(3,2)]);

%
% if a is infinity, the solution of eq. 18 reduces to u = b + Pij
%
if (a == inf)
    u = b + Pij;
    return
end

%
% if b is infinity, the solution of eq. 18 reduces to u = a + Pij
%
if (b == inf)
    u = a + Pij;
    return
end

%
% In the general case, eq 18 reduces to a second order equation
%
determ = 4*(a+b)^2 - 4*2*(a^2 + b^2 - Pij2);
if determ > 0
    determ = sqrt(determ);
else
    determ = 0;
end

u = (2*(a + b) + determ)/4;
