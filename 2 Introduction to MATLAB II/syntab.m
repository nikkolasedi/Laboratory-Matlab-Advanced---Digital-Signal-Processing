function varargout = syntab(in1, in2)
% syntab syndrome table 
% 
% syntab returns syndrome table as out1 to a given 
% parity check matrix and a number of correctable errors
% input1 (in1) = parity-check matrix
% input2 (in2) = number of correctable errors
% output (varargout(i)) = syndrome table

m = size(in1,2);
n = m - size(in1,1);
y = zeros(1,m);
% s = zeros(m+1,m-n);
% errv = zeros(m+1,m);
for j = 1:1:in2
ind = combnk(1:m, j);
s = zeros(size(ind,1),m-n);
errv = zeros(size(ind,1),m);
for i = 1:1:size(ind,1)
    y(ind(i,:)) = mod(y(ind(i,:))+1,2);
    s(i,:) = mod(y*in1.',2);
    y(ind(i,:)) = mod(y(ind(i,:))+1,2);
    
    errv(i,ind(i,:))=1;
end
%out1=table(errv,s);
varargout{j}=sortrows(table(errv,s));
end

%Backup
% for i = 1:1:m
%     y(m+1-i) = mod(y(m+1-i)+1,2);
%     s(i+1,:) = mod(y*in1.',2);
%     y(m+1-i) = mod(y(m+1-i)+1,2);
%     
%     errv(i+1,m+1-i)=1;
% end
% out1=table(errv,s);
