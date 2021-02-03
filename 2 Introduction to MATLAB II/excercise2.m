% First example
% m = 7;
% n = 4;
% g = [1 1 0 1]; % g = 1 + z + z^3

% Second example
% m = 15;
% n = 5;
% % g = [1 1 1 0 1 1]; % g = 1+z+z^2+z^4+z^5+z^8+z^10
% g = [1 1 1 0 1 1 0 0 1 0 1];

% Third example
m = 31;
n = 16;
g = [1 1 1 1 0 1 0 1 1 1 1 1 0 0 0 1]; % g = 1 + z + z^3
%% section1 
G = zyklgenmat(g,m,n);

%% section2
[Gsys, ~] = genmatsys(G, n);
%% section3
[~,parmat] = genmatsys(G, n);
%% section4
[x,~,~] = encoder(Gsys,n,m);
[~,y,~] = encoder(Gsys,n,m);
[~,~,H] = encoder(Gsys,n,m);
%% section5
e = codefeatures(Gsys, x, y, H);
%% section6
table = syntab(H,m);
%% section7
x_d = decoder(y, H, n);
