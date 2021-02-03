#include "mex.h"
void mexFunction( int nlhs, mxArray *plhs[],
int nrhs, const mxArray *prhs[])
{
double *y,*z;
double x;
int status,mrows,ncols;
/************ Argument Checking ****************************************/
/* check for proper number of arguments */
/* NOTE: You do not need an else statement when using mexErrMsgTxt
within an if statement, because it will never get to the else
statement if mexErrMsgTxt is executed. (mexErrMsgTxt breaks you out of
the MEX-file) */
if(nrhs!=2)
mexErrMsgTxt("Two inputs required.");
if(nlhs!=1)
mexErrMsgTxt("One output required.");
/* check to make sure the first input argument is a scalar */
if( !mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) ||
mxGetN(prhs[0])*mxGetM(prhs[0])!=1 ) {
mexErrMsgTxt("Input x must be a scalar.");
}
/************ Argument Data Extraction *********************************/
/* get the scalar input x */
x = mxGetScalar(prhs[0]);
/* create a pointer to the input matrix y */
y = mxGetPr(prhs[1]);
/* get the dimensions of the matrix input y */
mrows = mxGetM(prhs[1]);
ncols = mxGetN(prhs[1]);
/************ Creation of Output Argument Data *************************/
/* set the output pointer to the output matrix */
plhs[0] = mxCreateDoubleMatrix(mrows,ncols, mxREAL);
/* create a C pointer to a copy of the output matrix */
z = mxGetPr(plhs[0]);
/************ Call to custom function(s) *******************************/
/* call the C subroutine */
xtimesy(x,y,z,mrows,ncols);
}