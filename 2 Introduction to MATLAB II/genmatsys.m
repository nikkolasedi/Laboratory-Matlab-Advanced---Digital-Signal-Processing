function o = genmatsys(in)
% genmatsys systematic matrix converter
% 
% genmatsys returs the systematic form of a given generator matrix
% input 1 (in) = non-systemic matrix

n = size(in,1);
for i = 1:1:n-1
    for j = 1:1:i
        if(in(n-i,n+1-j)== 1)
            c = mod(in(n+1-j,:)+in(n-i,:),2);
            in(n-i,:) = c;
        else
            
        end
    end
end
o = in;
