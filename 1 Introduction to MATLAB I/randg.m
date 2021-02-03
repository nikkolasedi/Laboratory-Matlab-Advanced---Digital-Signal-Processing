function R = randg(M,N)
% RANDG  Gamma distributed random numbers.
%     
%     RANDG(M,N) or RANDG([M,N]) returns an M-by-N matrix containing pseudo-random values
%     drawn from a gamma distribution with mean zero. RANDG(M,N,P,...)
%     or RANDG([M,N,P,...]) returns an M-by-N-by-P-by-... array. RANDG(SIZE(A)) returns an array the
%     same size as A.
%  
%     Note: The size inputs M, N, and P... should be nonnegative integers.
