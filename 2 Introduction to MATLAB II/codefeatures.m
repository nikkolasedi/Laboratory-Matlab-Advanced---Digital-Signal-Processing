function [out1,out2] = codefeatures(in)
% codefeatures
% 
% codefeatures determines the minimum Hamming distance
% and the number of correctable bit errors of a code with a given generator
% matrix.
% input 1 (in) = generator matrix
% output 1 (out1) = minimum Hamming distance
% output 2 (out2) = number of correctable errors of code words

n = size(in,1);
info = dec2bin(0:2^n-1);
y = encoder(info,in);
ymin = setdiff(y,min(y),'rows');
count = min(sum(ymin,2));
% for i = 1:1:size(ymin,2)
%     if ymin(1,i) == 1
%         count=count+1;
%     end 
% end
        

out1 = count;
out2 = (count-1)/2;


