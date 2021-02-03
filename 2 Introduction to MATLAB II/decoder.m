function o = decoder(in1, in2, opt)

% determines the information word x corresponding to a valid code word y 
% of a systematic (m,n) code
% 
% input 1 (in1) = systemic generator matrix
% input 2 (in2) = code word
% optional input 3 (opt) = set to 1 to correct the codeword before decoding

n = size(in1,1);
m = size(in1,2);
y = in2;

if nargin < 3;
  opt = 0;
end

if opt == 1
    allx = dec2bin(0:2^n-1);
    ally = encoder(allx,in1);
    alld = zeros(size(ally,1),m);
    alldiff = zeros(size(ally,1),1);
    for i = 1:1:size(ally,1)
        alld(i,:)= mod(ally(i,:)+y,2);
    end
    
    for i = 1:1:size(ally,1)
        alldiff(i) = sum(alld(i,:));
    end
    
    if(min(alldiff)>0)
        [row,col] = find(alldiff == min(alldiff));
        y = ally(row,:);
    end
    
end

invg = zeros(n,m);
invg(1:n,1:n) = eye(n);

o = mod(y*invg',2);



    