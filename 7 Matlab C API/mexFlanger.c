#include "mex.h"
void mexFunction( int nlhs, mxArray *plhs[],
int nrhs, const mxArray *prhs[])
{
    
double *inputSignal, *outputSignal; 
int lengthInputSignal, mrows;
double samplingFreq, delay, gain, divertAmount, divertFrequency;
    
/************ Argument Checking ****************************************/
/* check for proper number of arguments */
/* NOTE: You do not need an else statement when using mexErrMsgTxt
within an if statement, because it will never get to the else
statement if mexErrMsgTxt is executed. (mexErrMsgTxt breaks you out of
the MEX-file) */
if(nrhs!=6) 
mexErrMsgTxt("Six inputs required.");
if(nlhs!=1)
mexErrMsgTxt("One output required.");
/* check to make sure the second till the last input argument is a scalar */
// for(int counter = 1; counter < 6; ++counter){
// if( !mxIsDouble(prhs[counter]) || mxIsComplex(prhs[counter]) ||
// mxGetN(prhs[counter])*mxGetM(prhs[counter])!=1 ) {
// mexErrMsgTxt("All input must be a scalar.");
// }
// }
int counter = 0;
for(counter;counter<nrhs;counter++){
if(counter < 1){
    if(mxIsComplex(prhs[counter])){
        mexErrMsgTxt("Input 1 must be vector of scalar.");
    }
}
else{
    if( !mxIsDouble(prhs[counter]) || mxIsComplex(prhs[counter]) ||
mxGetN(prhs[counter])*mxGetM(prhs[counter])!=1 ) {
mexErrMsgTxt("Input 2 till 6 must be a scalar.");
        }
    }
}
/************ Argument Data Extraction *********************************/
/* create a pointer to the input vector inputSignal*/
inputSignal = mxGetPr(prhs[0]);
lengthInputSignal = mxGetM(prhs[0]);
mrows = mxGetN(prhs[0]);
samplingFreq = mxGetScalar(prhs[1]);
delay = mxGetScalar(prhs[2]);
gain = mxGetScalar(prhs[3]); 
divertAmount= mxGetScalar(prhs[4]); 
divertFrequency = mxGetScalar(prhs[5]); 

/************ Creation of Output Argument Data *************************/
/* set the output pointer to the output matrix */
plhs[0] = mxCreateDoubleMatrix(mrows,lengthInputSignal, mxREAL);
/* create a C pointer to a copy of the output matrix */
outputSignal = mxGetPr(plhs[0]);

/************ Call to custom function(s) *******************************/
/* call the C subroutine */
flanger (inputSignal, lengthInputSignal,
         samplingFreq, delay, gain,
         divertAmount, divertFrequency, outputSignal);
}