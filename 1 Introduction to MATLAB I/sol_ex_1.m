close all;

% Excercise 1.1.1
[y, Fs] = audioread('speech.wav');
ap = audioplayer(y, Fs);
play(ap);

% Excercise 1.1.2
infor = audioinfo('speech.wav');
duration = infor.Duration; % duration of entire signal
t = 0:duration/(length(y)-1):duration; % time vector for entire signal
t_ex = t(5500:13499); % time vector for extract
ex = y(5500:13499); % extract

figure
plot(t_ex, ex)
xlabel('Time in s')
ylabel('Amplitude')
title('Extract of Audiosignal, 8000 samples starting from 5500')

% Excercise 1.1.3
M = max(y); % maximum of entire signal
m = min(y); % minimum of entire signal
am = mean(y); % arithmetic mean of entire signal
smv = mean(y.^2); % squared mean of entire signal
% sqrt(mean(y.^2)) script: 'mean of y.^2' what do they mean exactly?

% Excercise 1.1.4
figure
histogram(y, 32, 'BinLimits', [-0.25 0.25])
title('Histogram of Speech Signal')
% what is meant by resolution

% Excercise 1.1.5
r1 = rand(length(y), 1);
r2 = randn(length(y),1);
mex randg.c
r3 = randg(length(y),1);
%random1 = -0.25 + rand(1,length(y))*(0.5);
figure

subplot(1,3,1)
histogram(r1, 32, 'BinLimits', [min(r1) max(r1)])
title('Histogram for rand')

subplot(1,3,2)
histogram(r2, 32, 'BinLimits', [min(r2) max(r2)])
title('Histogram for randn')

subplot(1,3,3)
histogram(r3, 32, 'BinLimits', [min(r3) max(r3)])
title('Histogram for randg')

% rand: uniform distribution
% randn: normal distribution
% randg: gamma distribution x q2

% Excercise 1.2.1
yn = ((y-m)./(M-m)-0.5)*2; % normalize y to [-1, 1]
% Nikko: yn = y.*(1/max(abs(y)));

i1 = 1/8;
i2 = i1/4;
i3 = i2/4;

q1 = i1*round(yn/i1);
q2 = i2*round(yn/i2);
q3 = i3*round(yn/i3);
% qy = 0.25 * round(yn/0.25);

% Excercise 1.2.2
ap1 = audioplayer(q1, Fs);
play(ap1);
ap2 = audioplayer(q2, Fs);
play(ap2);
ap3 = audioplayer(q3, Fs);
play(ap3);

% Excercise 1.2.3
x = 69000:1:69499;

figure

subplot(2,2,1)
plot(x, y(69000:69499))
xlabel('No. of sample')
ylabel('Amplitude')
title('Original Signal')

subplot(2,2,2)
stairs(x, q1(69000:69499))
xlabel('No. of sample')
ylabel('Amplitude')
title('Quantized Signal, 4 bit precision')

subplot(2,2,3)
stairs(x, q2(69000:69499))
xlabel('No. of sample')
ylabel('Amplitude')
title('Quantized Signal, 6 bit precision')

subplot(2,2,4)
stairs(x, q3(69000:69499))
xlabel('No. of sample')
ylabel('Amplitude')
title('Quantized Signal, 8 bit precision')

% Excercise 1.2.4
e1 = q1 - yn;
e2 = q2 - yn;
e3 = q3 - yn;

% Excercise 1.2.5
figure

subplot(2,2,1)
histogram(y, 32, 'BinLimits', [-0.25 0.25])
title('Histogram of Original Signal')

subplot(2,2,2)
histogram(e1)
title('Histogram of Error Signal, 4 bit precision')

subplot(2,2,3)
histogram(e2)
title('Histogram of Error Signal, 6 bit precision')

subplot(2,2,4)
histogram(e3)
title('Histogram of Error Signal, 8 bit precision')

% higher precision -> smaller error, distribution of error: if maximum is
% in the middle -> higher error

% Excercise 1.2.6
yn1 = -0.01+0.02*((y-m)./(M-m));
%Nikko: y_n_1 = y.*(0.01/max(abs(y)));%rescale to  [-0.01,0.01]
q4 = i3/100*round(yn1/(0.01*i3));
ap4 =audioplayer(q4, Fs);
play(ap4);

% Excercise 1.2.7
% finding indices for values in saturation region
ind1 = find(abs(q1(69000:69499))==0.75);
ind2 = find(abs(q2(69000:69499))==0.75);
ind3 = find(abs(q3(69000:69499))==0.75);

figure

subplot(3,1,1)
plot(x, y(69000:69499))
hold on
plot(x(ind1), y(x(ind1)), 'r*')
hold on

xlabel('No. of sample')
ylabel('Amplitude')
title('Original Signal')

subplot(3,1,2)
plot(x, y(69000:69499))
hold on
plot(x(ind2), y(x(ind2)), 'b*')
hold on
xlabel('No. of sample')
ylabel('Amplitude')
title('Original Signal')

subplot(3,1,3)
plot(x, y(69000:69499))
hold on
plot(x(ind3), y(x(ind3)), 'g*')
hold on
xlabel('No. of sample')
ylabel('Amplitude')
title('Original Signal')

% Excercise 1.3
snr1 = 10*log10(sum(yn.^2)./sum(e1.^2));
snr2 = 10*log10(sum(yn.^2)./sum(e2.^2));
snr3 = 10*log10(sum(yn.^2)./sum(e3.^2));
e4 = q4 - yn;
snr4 = 10*log10(sum(yn.^2)./sum(e4.^2));

% Excercise 1.4.1
t1 = 0:1/((32*10^3)-1):1;
s = sin(2*pi*50*t1) + 0.4*sin(2*pi*110*t1) + 0.2*sin(2*pi*230*t1) + 0.05*sin(2*pi*600*t1);
s = ((s-min(s))./(max(s)-min(s))-0.5)*2;

figure
plot(t1,s)
xlabel('Time in s')
ylabel('Amplitude')

% Excercise 1.4.2
cs = cos(2*pi*12000*t1);

% Excercise 1.4.3
s_AM1 = (1+0.8*s).*cs;
s_AM2 = (1+1.8*s).*cs;
env1 = abs(hilbert(s_AM1));
env2 = abs(hilbert(s_AM2));

figure

subplot(3,1,1)
plot(t1, s_AM1)
xlabel('Time in s')
ylabel('Amplitude')
title('Modulated Signal, m = 0.8')

subplot(3,1,2)
plot(t1, env1)
xlabel('Time in s')
ylabel('Amplitude')
title('Envelope')

subplot(3,1,3)
plot(t1, s)
xlabel('Time in s')
ylabel('Amplitude')
title('Signal to be modulated')

figure

subplot(3,1,1)
plot(t1, s_AM2)
xlabel('Time in s')
ylabel('Amplitude')
title('Modulated Signal, m = 1.8')

subplot(3,1,2)
plot(t1, env2)
xlabel('Time in s')
ylabel('Amplitude')
title('Envelope')

subplot(3,1,3)
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