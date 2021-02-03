function [in_del] = frac_del(in, tau)

len = length(in);
in_del1 = zeros(8,len);
coeff = [-128:127];
for i = 0:7
    
k = round(tau(1+i)*8000);
in_del1(1+i,:) = conv(in,sinc(coeff-k),'same');

end

in_del = in_del1;

end
