/**************************************************************************/
/**
 *        File: mexNlmsVorlage.c
 *      Author: Aulis Telle
 * Description: Calculate NLMS Algorithm on given input signal and
 *              given system response 
 *        Date: 2005-11-02
 *     Version: 0.1
 **/
/*************************************************************************/

#include <stdio.h>
#include <string.h>
#include "mex.h"

void nlms (double* inputSignal, int lengthInputSignal, 
              int period, double* systemResponse,
              double alpha, double* impulseResponseMatrix, 
              int numberPeriods);


void mexFunction (int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{      
            
  /* ... */
   
   /* ******************************
    * DO ACTUAL CALCULATIONS
    * ******************************/
    
/************ Argument Checking ****************************************/
/* check for proper number of arguments */
/* NOTE: You do not need an else statement when using mexErrMsgTxt
within an if statement, because it will never get to the else
statement if mexErrMsgTxt is executed. (mexErrMsgTxt breaks you out of
the MEX-file) */

if(nrhs!=4) 
mexErrMsgTxt("Four inputs required.");
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
if(counter == 0 || counter == 2 ){
    if(mxIsComplex(prhs[counter])){
        mexErrMsgTxt("Input 1 must be vector of scalar.");
    }
}
else{
    if( !mxIsDouble(prhs[counter]) || mxIsComplex(prhs[counter]) ||
mxGetN(prhs[counter])*mxGetM(prhs[counter])!=1 ) {
mexErrMsgTxt("Input 2 and 4 must be a scalar.");
        }
    }
}


/************ Argument Data Extraction *********************************/

    double *inputSignal, *systemResponse, *impulseResponseMatrix;
    int lengthInputSignal, period, numberPeriods;
    double alpha;   
    
/* create a pointer to the input vector inputSignal*/
    inputSignal = mxGetPr(prhs[0]);
    period = mxGetScalar(prhs[1]);
    systemResponse =  mxGetPr(prhs[2]);
    alpha = mxGetScalar(prhs[3]);

    lengthInputSignal = mxGetM(prhs[0]);
    numberPeriods = mxGetM(prhs[0])/mxGetScalar(prhs[1]);
    
/************ Creation of Output Argument Data *************************/
    
    plhs[0] = mxCreateDoubleMatrix(period,numberPeriods, mxREAL);
    
    impulseResponseMatrix = mxGetPr(plhs[0]);
    
/************ Call to custom function(s) *******************************/
/* call the C subroutine */
   nlms (inputSignal, lengthInputSignal, period, systemResponse, alpha, 
            impulseResponseMatrix, numberPeriods);
   
}

/* === Main Computation Function === */
/*
 * nlms is the main calculation function. 
 * 
 */

#define MATRIX(MAT,ROW,COLUMN,ROWLEN)   MAT[(ROW) + (COLUMN) * (ROWLEN)]

void nlms (double* inputSignal, int lengthInputSignal, 
              int period, double* systemResponse,
              double alpha, double* impulseResponseMatrix, 
              int numberPeriods)
{
    int i;                  /* counter */
    int k;                  /* counter */
    int currentPeriod = 0;

    double *weightVec;
    double *inputCurrent;

    double norm;
    double y;
    double d_hat = 0;
    double error = 0;

    /* allocate memory */
    weightVec = (double*) malloc(sizeof(double) * period);
    
    for (i = 0; i < period; i++) {
        weightVec[i] = 0;
    }

    for (k = 0; k < (lengthInputSignal - period); k++) { 
        
        /* use pointer inputCurrent for current position in inputSignal for
         * readability */
        inputCurrent = &inputSignal[k];
        y            = systemResponse[k + period - 1];
        
        /* calculate an estimate for d_hat */
        d_hat = 0;
        for (i = 0; i < period; i++){
            d_hat += weightVec[i] * inputCurrent[i];
        }
        
        /* calc error */
        error = y - d_hat;
        
        /* calc norm */
        norm = 0;
        for (i = 0; i < period; i++) {
            norm += inputCurrent[i] * inputCurrent[i];
        }
        
        /* update filter */
        for (i = 0; i < period; i++) {
            weightVec[i] = weightVec[i] 
                + alpha * error * inputCurrent[i] / norm;
        }
        
        /* flip every period-th weightVec and save it to output */
        if ( (k % period == 0) && (currentPeriod < numberPeriods) ) {
            for (i = 0; i < period; i++) {
                MATRIX(impulseResponseMatrix, i, currentPeriod, period) 
                    = weightVec[period - 1 - i];
            }
            
            currentPeriod++;
        }
       
    }
    
    /* free memory again */
    free(weightVec);
}
