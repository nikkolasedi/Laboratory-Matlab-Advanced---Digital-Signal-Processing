#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <limits.h>

#include "flanger.h"

#define M_Pi 3.14159265

/**
 * @brief Apply flanger effect on input signal
 */
void
flanger (double* inputSignal, int lengthInputSignal,
         double samplingFreq, double delay, double gain,
         double divertAmount, double divertFrequency, double* outputSignal)
{
   int i;
   int j;
   int recursive = 1;
   int currentDelay;

   double temp;
   double  tempDivert;
   double  startPhase;
   double* sigPointer;
   
   startPhase = 2.0 * M_PI * ((double) rand() / LONG_MAX);
   if (gain >= 1)
   {
      gain = 0.99;
   }
   
   if (recursive == 1)
   {
      sigPointer = outputSignal;
   }
   else
   {
      sigPointer = inputSignal;
   }


   /* convert to sample based values */
   delay = floor(delay / 1000.0 * samplingFreq);
   divertFrequency = divertFrequency;
   divertAmount = floor(divertAmount / 1000.0 * samplingFreq);
   
   for (i = 0; i < lengthInputSignal; i++)
   {
      outputSignal[i] = inputSignal[i];
      
      tempDivert = divertAmount;
      if (tempDivert >= delay)
      {
         tempDivert = delay - 1;
      }

      currentDelay = (int)delay
         + (int)floor(tempDivert
                      * sin(2 * M_PI * divertFrequency * (double)i / samplingFreq) + startPhase );
         
      if (currentDelay < i)
      {
         outputSignal[i] += gain * sigPointer[i - currentDelay];
      }
   }

   return;
}
