/*
* xtimesy.c - example found in API guide
*
* multiplies an input scalar times an input matrix and outputs a
* matrix
*
* This is a MEX-file for MATLAB.
* Copyright 1984-2000 The MathWorks, Inc.
*/
#include "mex.h"
void xtimesy(double x, double *y, double *z, int m, int n)
{
int i,j,count=0;
for (i=0; i<n; i++) {
for (j=0; j<m; j++) {
*(z+count) = x * *(y+count);
count++;
}
}
}
/* the gateway function */
