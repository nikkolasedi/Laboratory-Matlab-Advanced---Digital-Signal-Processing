 function y = converter(x, varargin)

x_r = round((x+1)*2^15);%Quantize to 16 bit precision
y = decimal2binaryfast(x_r);%Convert to binary representation
