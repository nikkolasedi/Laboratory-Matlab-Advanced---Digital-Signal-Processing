function B = decimal2binary(D)
%DECIMAL2BININARY Convert decimal integer to its binary representation.
%   DECIMAL2BINARY(D) returns the binary representation of D as an array
%   of ones and zeros, the leftmost one being the most significatn bit
%   (MSB). If D is an array a matrix is returned with on row for each
%   element in D.
%
%   D must be a non-negative integer smaller than 2^52. 
%   

%
% Check input
%

sz = size(D);

if ~isnumeric(D)
    error('Matrix D must be numeric');
end

if length(sz) > 2 | (sz(1) ~= 1 & sz(2) ~= 1)
    error('Matrix D must be an array');
end


%
% Calculate binary representation
%

len = length(D);

% determine maximum required number of bits
emax = 0;
for k =  1:len
    [f,e] = log2(D(k));
    % e is the number of bits needed te represent D(k)
    
    if e > emax
        emax = e;
    end
end

for k = 1:len
   for m = 1:emax
       b(m) = rem(floor(D(k) / pow2(emax-m)),2);
   end
   B(k,:) = b;
end
