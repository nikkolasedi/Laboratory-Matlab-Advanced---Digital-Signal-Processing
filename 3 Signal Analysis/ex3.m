% Exercise 3
close all;
%% Exercise 3.1
x1 = rand(1,10^6)*4;
x2 = 2+sqrt(0.5)*randn(1,10^6);
x3 = 2+sqrt(1.5)*randn(1,10^6);

mean(x1);
mean(x2);
mean(x3);
var(x2);
var(x3);

bins = -2:0.1:6;
h1 = hist(x1, bins);
h2 = hist(x2, bins);
h3 = hist(x3, bins);

figure

subplot(1,2,1)
plot(bins,h1,bins,h2,'--',bins,h3,'*');
title('Histogram')

p1 = h1/sum(h1);
p2 = h2/sum(h2);
p3 = h3/sum(h3);

c1 = cumsum(p1);
c2 = cumsum(p2);
c3 = cumsum(p3);

subplot(1,2,2)
plot(bins,c1,bins,c2,'--',bins,c3,'*');
title('Cumulative Distribution Function');

close;

%% Exercise 3.2
load('voice1.mat');
fs = 8*10^3;
tt = size(voice1,1)/fs;%Duration of voice1.mat is 100ms
t = 1/fs : 1/fs : tt;
[phi_voice1,lags] = xcorr(voice1);
plot(lags,phi_voice1);%First sidelobes lamda =+-55 -> f = 8000/55 = 145.4545
hold on;

load('sequences.mat','x','y1','y2','y3');
figure;

subplot(2,2,1);
[phi_xx,lags] = xcorr(x);
plot(lags,phi_xx);
title('Autoorrelation-x');

subplot(2,2,2);
[phi_xy1,lags] = xcorr(x,y1);
plot(lags,phi_xy1);
title('Correlation-x-y1');%y1 uncorrelated to x

subplot(2,2,3);
[phi_xy2,lags] = xcorr(x,y2);
plot(lags,phi_xy2);
title('Correlation-x-y2');%y2 correlated to x, shifted 14 and scaled 0,86

subplot(2,2,4);
[phi_xy3,lags] = xcorr(x,y3);
plot(lags,phi_xy3);
title('Correlation-x-y3');%y3 correlated to x, shifted 0 and scaled 2

close;

%% Exercise 3.3

t = (0:64-1);

xi1 = t==0;
xi2 = t==1;
xi3 = t==2;
plot(t,xi1, t, xi2, t, xi3);

X1 = fft(xi1);
X2 = fft(xi2);
X3 = fft(xi3);

figure
subplot(3,2,1)
plot(t,abs(X1));
title('Magnitude X1');
subplot(3,2,2)
plot(t,angle(X1));
title('Phase X1');

subplot(3,2,3)
plot(t,abs(X2));
title('Magnitude X2');
subplot(3,2,4)
plot(t,angle(X2));
title('Phase X2');

subplot(3,2,5)
plot(t,abs(X3));
title('Magnitude X3');
subplot(3,2,6)
plot(t,angle(X3));
title('Phase X3');

close;
N = 5;
xc1 = cos(2*pi*t/N);
xc2 = cos(t/N);
XC1 = fft(xc1);
XC2 = fft(xc2);

figure
subplot(2,2,1)
plot(t,abs(XC1));
title('Magnitude XC1');
subplot(2,2,2)
plot(t,angle(XC1));
title('Phase XC1');

subplot(2,2,3)
plot(t,abs(XC2));
title('Magnitude XC2');
subplot(2,2,4)
plot(t,angle(XC2));
title('Phase XC2');

close;

%% Exercise 3.4
load('distorted.mat', 'x');
l = size(x,1);
fs4 = 8*10^3;
f4 = fs4*(0:l-1)/l;
t4 = 0:1/fs4:l/fs4-1/fs4;
X4 = fft(x);
figure
subplot(1,3,1)
plot(t4, x');
title('Signal x');
subplot(1,3,2)
plot(f4,abs(X4));
title('Magnitude X4');
subplot(1,3,3)
plot(f4,angle(X4));
title('Phase X4');

%f = (960,1000,2000)
%A = (5013,2583,2465)

close;
%% Exercise 3.5
load('voice2.mat');
l = size(voice2,1);
fs = 8000;
t = 0 : 1/fs : l-1/fs;
spectrogram(voice2,blackman(200),100,200,fs,'yaxis');

ap = audioplayer(voice2, fs);
play(ap);