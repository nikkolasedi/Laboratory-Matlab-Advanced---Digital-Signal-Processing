#include "mex.h"

#include <math.h>
#include <stdio.h>

#define IA 16807
#define IM 2147483647
#define AM (1.0/IM)
#define IQ 127773
#define IR 2836
#define NTAB 32
#define NDIV (1+(IM-1)/NTAB)
#define EPS 1.2e-7
#define RNMX (1.0 - EPS)


static double ran1 (long *idum);
static void randgam (double* vals, int num);
static double gamdev (int ia, long *idum);


void mexFunction(int nlhs, mxArray *plhs[], int nrhs,
                 const mxArray *prhs[])
{
  double *x, *y, *dims;
  int mrows, ncols, numelements, i;
  mwSize numdims;
  mwSize *idims;
  
  /* Check for proper number of arguments. */
  if (nrhs < 1) {
    mexErrMsgTxt("At least one input required.");
  } else if (nlhs > 1) {
    mexErrMsgTxt("Too many output arguments");
  }
  
  if (nrhs == 1)
  {
      /* The input must be a noncomplex scalar double.*/
      mrows = mxGetM(prhs[0]);
      ncols = mxGetN(prhs[0]);
      
      if (mrows != 1 && ncols != 1)
      {
          mexErrMsgTxt("Argument must be a vector");
      }
      numdims = (mrows > ncols ? mrows : ncols);
      
      dims = mxGetPr (prhs[0]);
      idims = mxCalloc (numdims, sizeof(int));
      
      if (numdims == 1) 
      {
          numelements = floor (dims[0]);
          numelements *= numelements;
      }
      else
      {
          numelements = 1;
          for (i = 0; i < numdims; i++)
          {
              idims[i] = floor(dims[i]);
              if (idims[i] > 0) 
              {
                  numelements *= idims[i];
              }
          }
      }
  }
  
  else 
  {
      idims = mxCalloc (nrhs, sizeof(int));
      numelements = 1;
      numdims = nrhs;
      for (i = 0; i < numdims; i++)
      {
          if (!mxIsDouble(prhs[i]) || mxIsComplex(prhs[i]))
          {
              mexErrMsgTxt ("Arguments must be scalar non-complex double values");
          }
          idims[i] = floor(mxGetScalar(prhs[i]));
          if (idims[i] > 0)
          {
              numelements *= idims[i];
          }
      }    
  }
  
  plhs[0] = mxCreateDoubleMatrix(numelements, 1, mxREAL);
  y = mxGetPr (plhs[0]);
  
  randgam (y, numelements);
  
  mxSetDimensions (plhs[0], idims, numdims);
  
  return;
  
}


static void randgam (double* vals, int num)
{
    int i;
    long idum = 1;
    for (i = 0; i < num; i++)
    {
        vals[i] = gamdev (1, &idum);
    }
    return;
}

/**********************************************************************/
static double gamdev (int ia, long *idum)
{
   int j;

   double am, e, s, v1, v2, x, y;

   if (ia < 1)
   {
      /* ERROR */
   }

   if (ia < 6) 
   {
      x = 1.0;
      for (j = 1; j <= ia; j++)
      {
         x *= ran1(idum);
      }
      x = -log(x);
   }
   else 
   {
      do
      {
         do
         {
            do
            {
               v1 = ran1 (idum);
               v2 = 2.0 * ran1(idum) - 1.0;
            } while (v1 * v1 + v2 * v2 > 1.0);
            y = v2 / v1;
            am = ia - 1;
            s = sqrt (2.0 * am + 1);
            x = s * y + am;
         } while (x <= 0.0);
         e = (1.0 + y * y) * exp (am * log (x / am) - s * y);
      } while (ran1 (idum) > e);
   }
   v1 = ran1 (idum);
   if (v1 < 0.5) 
   {
      x = -x;
   }
   return x;
}


/**********************************************************************/
static double ran1 (long *idum)
{
   int j;
   long k;
   static long iy = 0;
   static long iv[NTAB];
   double temp;
   
   if (*idum <= 0 || !iy)     /*  Initialize */
   {
      if (-(*idum) < 1)       /* Be sure to prevent idum = 0 */
      {
         *idum	 = 1;
      }
      else
      {
         *idum = -(*idum);
      }
      for (j = NTAB + 7; j >= 0; j--) /* Load the shue table after 8
                                       * warm-ups */
      {
         k = (*idum) / IQ;
         *idum = IA * (*idum - k * IQ) - IR * k;
         if (*idum < 0)
         {
            *idum += IM;
         }
         
         if (j < NTAB)
         {
            iv[j] = *idum;
         }
      }
      iy	= iv[0];
   }
   k = (*idum) / IQ; /* Start here when not initializing */
   *idum = IA * (*idum - k * IQ) - IR * k; /* Compute idum IAidum IM
                                            * without overflows by
                                            * Schrage's method */
   
   if (*idum < 0)
   {
      *idum += IM;
   }
   j = iy/NDIV;                            /* Will be in the range
                                            * 0..MTAB-1 */
   iy	= iv[j];                             /* Output previously stored
                                            * value and rell the
                                            * shuffle table */
   iv[j] = *idum;
   if ((temp = AM * iy) > RNMX)            /*  Because users dont
                                            *  expect endpoint
                                            *  values */
   {
      return RNMX;
   }
   else
   {
      return temp;
   }
}
