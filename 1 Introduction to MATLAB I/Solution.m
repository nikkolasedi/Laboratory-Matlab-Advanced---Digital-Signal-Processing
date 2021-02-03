close all;

% Exercise 1 Introduction to MATLAB I

% Excercise 1.1.1
[y, Fs] = audioread('speech.wav');%Store audio file and its sample rate (16000)
sound(y, Fs); % play audio file with its sample rate

% Excercise 1.1.2
info = audioinfo('speech.wav');%Extract the information of the audio
t = 0:1/Fs:info.Duration-(1/Fs);%Create the entire time axis
t_ex = t(5500:1:5500+8000-1);%Extract time axis 8000 samples starting from 5500
y_ex = y(5500:1:5500+8000-1);%Extract audio file 8000 samples starting from 5500

figure
plot(t_ex, y_ex)
xlabel('Time[s]')
ylabel('y')
title('Extract of Audiosignal, 8000 samples starting from 5500')

% Excercise 1.1.3
y_max = max(y);
y_min = min(y);
y_mean = mean(y);
y_sqmean = mean(y.^2);

% Excercise 1.1.4
figure;
histogram(y, 32, 'BinLimits', [-0.25 0.25]);
title('Histogram of Speech Signal');

% Excercise 1.1.5
r_1 = rand(1,length(y));%Generate random signal
r_2 = randn(1,length(y));
r_3 = randg(1,length(y));

figure;%Generate histograms for random signal

subplot(2,2,1);
histogram(r_1, 32, 'BinLimits', [min(r_1) max(r_1)]);
title('Histogram of rand');

subplot(2,2,2);
histogram(r_2, 32, 'BinLimits', [min(r_2) max(r_2)]);
title('Histogram of randn');

subplot(2,2,3);
histogram(r_3, 32, 'BinLimits', [min(r_3) max(r_3)]);
title('Histogram of randg');

subplot(2,2,4);
histogram(y, 32, 'BinLimits', [-0.25 0.25]);
title('Histogram of Speech Signal');


%rand = uniform distribution
%randn = normal distribution
%rand = gamma distribution

% Excercise 1.2.1
y_n = y.*(1/max(abs(y))); %Normalize the input within [-1,1] 
%Tai's solution >> yn = ((y-m)./(M-m)-0.5)*2;

i_1 = 1/(16/2);%quantization with 4 bits
i_2 = 1/(62/2);%quantization with 6 bits
i_3 = 1/(256/2);%quantization with 8 bits

q_1 = i_1*round(y_n/i_1);
q_2 = i_2*round(y_n/i_2);
q_3 = i_3*round(y_n/i_3);

% Excercise 1.2.2
sound(q_1, Fs);
sound(q_2, Fs);
sound(q_3, Fs);

% Excercise 1.2.3
figure
subplot(2,2,1)
plot(y(28000:1:28500-1));
title('Original Signal')
xlabel('No. of sample')
ylabel('Amplitude')

subplot(2,2,2)
stairs(q_1(28000:1:28500));
title('Quantized Signal, 4 bit precision')
xlabel('No. of sample')
ylabel('Amplitude')

subplot(2,2,3)
stairs(q_2(28000:1:28500));
title('Quantized Signal, 6 bit precision')
xlabel('No. of sample')
ylabel('Amplitude')

subplot(2,2,4)
stairs(q_3(28000:1:28500));
title('Quantized Signal, 8 bit precision')
xlabel('No. of sample')
ylabel('Amplitude')


% Excercise 1.2.4
err_1 = q_1 - y_n;
err_2 = q_2 - y_n;
err_3 = q_3 - y_n;

% Excercise 1.2.5
figure

subplot(2,2,1)
histogram(y, 32, 'BinLimits', [-0.25 0.25])
title('Histogram of Original Signal')

subplot(2,2,2)
histogram(err_1, 32, 'BinLimits', [-0.25 0.25])
title('Histogram of Error Signal, 4 bit precision')

subplot(2,2,3)
histogram(err_2, 32, 'BinLimits', [-0.25 0.25])
title('Histogram of Error Signal, 6 bit precision')

subplot(2,2,4)
histogram(err_3, 32, 'BinLimits', [-0.25 0.25])
title('Histogram of Error Signal, 8 bit precision')

%The more the bit precision, the more and higher bar in histogram concentrated in the zero/middle 


% Excercise 1.2.6
y_n_1 = y.*(0.01/max(abs(y)));%rescale to  [-0.01,0.01]
q_4 = i_3*0.01*round(y_n_1/(i_3*0.01));%quantize with 8 bit
sound(q_4, Fs);
%Amplitude smaller, voice quiter. No difference to quantization.

% Excercise 1.2.7
% finding indices for values in saturation region
ind1 = find(abs(q_1(69000:69499))==0.75);
ind2 = find(abs(q_2(69000:69499))==0.75);
ind3 = find(abs(q_3(69000:69499))==0.75);

figure

subplot(3,1,1)
plot(t, y(69000:69499))
hold on
for N = 1:1:length(ind1)
    plot(t(ind1(N)), y(x(ind1(N))), 'r*')
    hold on
end
xlabel('No. of sample')
ylabel('Amplitude')
title('Original Signal')
% plot(y_n);
% hold on;
% plot(y_n(find(y_n>1-i_1)),'*');

% Excercise 1.3
snr_1 = 10*log10(sum(y_n.^2)./sum(err_1.^2));
snr_2 = 10*log10(sum(y_n.^2)./sum(err_2.^2));
snr_3 = 10*log10(sum(y_n.^2)./sum(err_3.^2));
err_4 = q_4 - y_n;
snr_4 = 10*log10(sum(y_n.^2)./sum(err_4.^2));


% Excercise 1.4.1
t1 = 0:1/((32*1000)-1):1;
s = sin(2*pi*50*t1) + 0.4*sin(2*pi*110*t1) + 0.2*sin(2*pi*230*t1) + 0.05*sin(2*pi*600*t1);
s = ((s-min(s))./(max(s)-min(s))-0.5)*2;

% Excercise 1.4.2
cs = cos(2*pi*12000*t1);

% Excercise 1.4.3
s_AM1 = (1+0.8*s).*cs;
s_AM2 = (1+1.8*s).*cs;
env1 = abs(hilbert(s_AM1));
env2 = abs(hilbert(s_AM2));

figure

subplot(3,2,1)
plot(t1, s_AM1)
xlabel('Time in s')
ylabel('Amplitude')
title('Modulated Signal, m = 0.8')

subplot(3,2,3)
plot(t1, env1)
xlabel('Time in s')
ylabel('Amplitude')
title('Envelope')

subplot(3,2,5)
plot(t1, s)
xlabel('Time in s')
ylabel('Amplitude')
title('Signal to be modulated')

subplot(3,2,2)
plot(t1, s_AM2)
xlabel('Time in s')
ylabel('Amplitude')
title('Modulated Signal, m = 1.8')

subplot(3,2,4)
plot(t1, env2)
xlabel('Time in s')
ylabel('Amplitude')
title('Envelope')

subplot(3,2,6)
plot(t1, s)
xlabel('Time in s')
ylabel('Amplitude')
title('Signal to be modulated')

% signal can only be received w/o errors for m = 0.8
% in case of overmodulation sine-waves overlap in such way that the
% original sine wave cannot be detected by the envelope

% Excercise 1.4.4
s_ana1 = hilbert(s_AM1); % analytical signal, m = 0.8
s_AMe1 = s_ana1.*exp(-1i*2*pi*12000*t1); % complex envelope
s_demod1 = (1/0.8)*(abs(s_AMe1)-1); % demodulated signal

s_ana2 = hilbert(s_AM2); % analytical signal, m = 1.8
s_AMe2 = s_ana2.*exp(-1i*2*pi*12000*t1); % complex envelope
s_demod2 = (1/1.8)*(abs(s_AMe2)-1); % demodulated signal

figure

subplot(3,1,1)
plot(t1,s)
xlabel('Time in s')
ylabel('Amplitude')
title('Original Signal')

subplot(3,1,2)
plot(t1, s_demod1)
xlabel('Time in s')
ylabel('Amplitude')
title('Demodulated Signal, m = 0.8')

subplot(3,1,3)
plot(t1, s_demod2)
xlabel('Time in s')
ylabel('Amplitude')
title('Demodulated Signal, m = 1.8')

