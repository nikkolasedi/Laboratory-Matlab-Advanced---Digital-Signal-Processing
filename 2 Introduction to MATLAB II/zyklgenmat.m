function [o1,varargout] = zyklgenmat(v,m,b,c)
% zyklgenmat cyclic non-systematic matrix generator
% 
% zyklgenmat(v,m) returns the non-systematic generator matrix
% to a given generator polynomial of a cyclic (m,n) block code.
%
% input 1 (v) = vector of length m-n+1 
% input 2 (m)= number of column
% optional input 3 (b)= set to 1 to generate automatically systematic matrix
% optional input 4 (c)= set to 1 to generate automatically parity-check matrix
%
% output 1 (o1) = non-sys matrix if b = 0 and sys matrix if b = 1
% optional output 2 = parity-check matrix


if nargin < 1
  error('polynomials are first required input')
end

if nargin < 2
  error('the number of the columns is also second required input')
end

if nargin < 3
  b = 0;
end

if nargin < 4
  c = 0;
end

if size(v,1)<size(v,2)
    v = v';
end
s = size(v,1);
n = m-s+1;
a = zeros(n,m);

for i = 1:1:n %iterate row
    for j = 1:1:s %iterate column 
        a(i,j+i-1) = v(j,1);%assign value
    end
end

o1 = a;

%b systematic matrix 
 
if (b==1)
    o1 = genmatsys(o1);
else
end

%c parity matrix generator

if (nargin > 3)
    
    if nargout<2
        error('second output argument is needed for parity check matrix H')
    end
    
    if (c==1)
        o1temp = genmatsys(o1);
        h1 = eye(m-n);
        h2 = o1temp(1:n, n+1:m);
        h = zeros(m-n,m);
        h(1:m-n,1:n)= h2';
        h(1:m-n,n+1:m)= h1;
        varargout{1} = h;
    
    else
        
        varargout{1} = 0;
        
end
end