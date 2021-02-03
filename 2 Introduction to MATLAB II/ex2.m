%Exercise 2

%% First example
% m = 7;
% n = 4;
% g = [1 1 0 1]; % g = 1 + z + z^3

% Second example
% m = 15;
% n = 5;
% g = [1 1 1 0 1 1 0 0 1 0 1];% g = 1+z+z^2+z^4+z^5+z^8+z^10

% Third example
m = 31;
n = 16;
g = [1 1 1 1 0 1 0 1 1 1 1 1 0 0 0 1]; 

%% 2.1.1
mat = zyklgenmat(g,m);

%% 2.1.2
matsys = genmatsys(mat);

%% 2.1.3
[mat,parmat] = zyklgenmat(g,m,0,1);
%[mat,parmat] = zyklgenmat(g,m,1,1);

%% 2.1.4
% First example code information
% x = [1 1 0 1];
% x = [1 1 0 1;0 1 1 1];
% x = dec2bin(0:2^4-1);

% Second example code information
% x = [1 1 0 0 1];

% Third example code information
x = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
y = encoder(x,matsys);

%% 2.1.5
[mind,core] = codefeatures(matsys);

%% 2.1.6
% First example for 1 correctable error
[tabs1] = syntab(parmat,core);

% Second example for 3 correctable errors
%  [tabs1,tabs2,tabs3] = syntab(parmat,core);
%% 2.1.7
%Error addition
errv = [1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
y2 = mod(y+errv, 2);
decx = decoder(matsys,y2,1);
[x;decx]


