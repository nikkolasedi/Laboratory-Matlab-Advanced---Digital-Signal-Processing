function B = decimal2binaryfast(D)
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

% Optimized
% sz = size(D);

if ~isnumeric(size(D))
    error('Matrix D must be numeric');
end

if length(size(D)) > 2 || (size(D,1) ~= 1 && size(D,2) ~= 1)
    error('Matrix D must be an array');
end


%
% Calculate binary representation
%

% Optimized
% len = length(D);

% determine maximum required number of bits

%Optimized
% for k =  1:length(D)
%     [~,e] = log2(D(k));
%     % e is the number of bits needed te represent D(k)
%     
%     if e > emax
%         emax = e;
%     end
%     
% end

%emax = max(log2(D));

[~,e] = (log2(D));
emax = max(e);


%Reserved space
%b = zeros(1,emax);
B = zeros(length(D),emax);

% for k = 1:length(D)
%     
%    for m = 1:emax
%        b(m) = rem(floor(D(k) / pow2(emax-m)),2);
%    end
%    B(k,:) = b;
% end

for k = 1:length(D)
   %emax-1:-1:0
   %(10:10:30)' ./ (1:3)
   B(k,:) = flip(rem(floor(D(k) ./ pow2(0:emax-1)),2),2);

end



