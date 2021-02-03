/**
 * Apply flanger effect on input signal
 * 
 * @param [in]  inputSignal       Pointer to input signal vector
 * @param [in]  lengthInputSignal Number of samples in inputSignal
 * @param [in]  samplingFreq      Sampling frequency
 * @param [in]  delay             Delay in ms
 * @param [in]  gain              Gain (< 1)
 * @param [in]  divertAmount      Diversion amount for delay in ms
 * @param [in]  divertFrequency   Frequency of sinusoidal
 *                                diversion in Hz
 * @param [out] outputSignal      Pointer to output signal vector.
 *                                The vector has to have at least the length
 *                                of inputSignal
 */

void
flanger (double* inputSignal, int lengthInputSignal, double samplingFreq,
         double delay, double gain, double divertAmount,
         double divertFrequency, double* outputSignal);
