function [y] = encoder(x,G)

% encoder computes the code word y to an information
% word x and a generator matrix G
% 
% input 1 (x) = code information
% input 2 (G) = generator matrix
% output y = code word

yt = mod(x*G,2);
if size(x,1)>1 && size(x,2)>1
    n = size(x,1);
    %mat = zeros(n,1);
    mat2 = zeros(size(yt,1),1);
    %mat = bin2dec(num2str(reshape(yt, n, [])));
    for i = 1:size(yt,1)
        mat2(i) = bin2dec(strrep(num2str(yt(i,:)),' ', ''));
    end
    mat2 = sort(mat2, 'ascend');
    mat2 = decimalToBinaryVector(mat2);
    y = mat2;
else
    y = yt;
end
    
end
        