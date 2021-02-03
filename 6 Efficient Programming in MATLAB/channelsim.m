function y = channelsim(x, varargin)

%Optional input 1 to set ratio E_b/N_0
if nargin > 1
    in = varargin{1};
else 
    in = 1;
end

%Optional input 2 to set code rate k/n
if nargin > 2
    in2 = sqrt(varargin{2});
else
    in2 = 1;
end

var = 1./(2.*10.^((in-1)/10));

ind1 = x>0;
ind0 = x==0;

%x(x>0) = -in2;
x(ind1) = -in2;
x(ind0) = in2;

x = x+sqrt(var)*randn(size(x));

ind1 = x>=0;
ind0 = x<0;

x(ind1) = 0;
x(ind0) = 1;

y = x;

