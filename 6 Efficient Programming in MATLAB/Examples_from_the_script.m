%% Efficient Programming using MATLAB
% Exercise 7.1
% Examples from the script

%% MATLAB Stop watch
x = 0;
tic
for k = 1:1000
    x = x + k;
end
toc

%% Saving Tic Toc
tall = tic;
x = 0;
for k=1:10
    tpart = tic;
    x = x+k;
    toc(tpart);
end
disp('Total Duration:');
toc(tall);

%% Vectorization - Loops
loop = tic;
t = 0:0.01:100;
s = rand(size(t));

for k = 1:length(t)
    A(1,k) = sin(t(k));
    A(2,k) = cos(t(k));
end

% Multiplication
for k = 1:size(A,1)
    for l = 1:size(A,2)
        r(k,l) = A(k,l) * s(l);
    end
end

% square, addition, square root
for l = 1:size(r,2)
    result(l) = sqrt(r(1,l)^2 + r(2,l)^2);
end
disp('Total Duration for loops:');
toc(loop);
%% Vectorization - Vectorized
vec = tic;
t = 0:0.01:100;
s = rand(size(t));

A = [sin(t); cos(t)];
S = repmat(s,2,1);
result = sqrt(sum((A .* S).^2));
disp('Total Duration for vectorized:');
toc(vec);
%% Memory preallocation - not preallocated case
x = 0;
tic;
for k = 2:100000
    x(k) = x(k-1) + 10;
end
toc

%% Memory preallocation - preallocated case
x = zeros(1,100000);
tic;
for k = 2:100000
    x(k) = x(k-1) + 10;
end
toc

