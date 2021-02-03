load testsig
load response

mex mexNlmsVorgabe1.c

sysimp = mexNlmsVorgabe1(testsig, 500, response, 1);

mesh(sysimp); view(2); axis tight;

