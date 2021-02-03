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
legend('h1','h2','h3')

p1 = h1/sum(h1);
p2 = h2/sum(h2);
p3 = h3/sum(h3);

c1 = cumsum(p1);
c2 = cumsum(p2);
c3 = cumsum(p3);

subplot(1,2,2)
plot(bins,c1,bins,c2,'--',bins,c3,'*');
title('Cumulative Distribution Functions');
legend('c1','c2','c3')

% close;

%% Exercise 3.2
load('voice1.mat');
fs = 8*10^3;
tt = size(voice1,1)/fs;%Duration of voice1.mat is 100ms
t = 1/fs : 1/fs : tt;
[phi_voice1,lags] = xcorr(voice1);

figure
plot(lags,phi_voice1);%First sidelobes lamda =+-55 -> f = 8000/55 = 145.4545
title('Autocorrelation of voice1')

load('sequences.mat','x','y1','y2','y3');

figure

subplot(2,2,1)
[phi_xx,lags] = xcorr(x);
plot(lags,phi_xx);
legend('Autocorrelation-x');

subplot(2,2,2)
[phi_xy1,lags] = xcorr(x,y1);
plot(lags,phi_xy1);
hold on
[phi_xx,lags] = xcorr(x);
plot(lags,phi_xx);
legend('Correlation-xy1', 'Autocorrelation-x') % y1 and x uncorrelated

subplot(2,2,3)
[phi_xy2,lags] = xcorr(x,y2);
plot(lags,phi_xy2);
hold on
[phi_xx,lags] = xcorr(x);
plot(lags,phi_xx);
legend('Correlation-xy2', 'Autocorrelation-x'); %y2 correlated to x, shifted 14 and scaled 0,86

subplot(2,2,4)
[phi_xy3,lags] = xcorr(x,y3);
plot(lags,phi_xy3);
hold on
[phi_xx,lags] = xcorr(x);
plot(lags,phi_xx);
legend('Correlation-xy3', 'Autocorrelation-x'); %y3 correlated to x, shifted 0 and scaled 2

% close;

%% Exercise 3.3

t = (0:64-1);

x0 = t==0;
x1 = t==1;
x2 = t==2;

X0 = fft(x0);
X1 = fft(x1);
X2 = fft(x2);

magX0 = abs(X0);
magX1 = abs(X1);
magX2 = abs(X2);

argX0 = angle(X0);
argX1 = angle(X1);
argX2 = angle(X2);

reX0 = real(X0);
reX1 = real(X1);
reX2 = real(X2);

imX0 = imag(X0);
imX1 = imag(X1);
imX2 = imag(X2);

figure
subplot(3,2,1)
plot(abs(X0));
title('Magnitude X0');
subplot(3,2,2)
plot(angle(X0));
title('Phase X0');

subplot(3,2,3)
plot(abs(X1));
title('Magnitude X1');
subplot(3,2,4)
plot(angle(X1));
title('Phase X1');

subplot(3,2,5)
plot(abs(X2));
title('Magnitude X2');
subplot(3,2,6)
plot(angle(X2));
title('Phase X2');

figure
subplot(3,2,1)
plot(reX0)
title('Real Part of X0')

subplot(3,2,2)
plot(imX0)
title('Imaginary Part of X0')

subplot(3,2,3)
plot(reX1)
title('Real Part of X1')

subplot(3,2,4)
plot(imX1)
title('Imaginary Part of X1')

subplot(3,2,5)
plot(reX2)
title('Real Part of X2')

subplot(3,2,6)
plot(imX2)
title('Imaginary Part of X2')

n0 = round(10*abs(randn));
n1 = abs(randn);
k = 0:63;

omega0 = 2*pi*n0/64;
omega1 = 2*pi*n1/64;

xk0 = cos(omega0*k);
Xk0 = fft(xk0);
magXk0 = abs(Xk0);
argXk0 = angle(Xk0);
reXk0 = real(Xk0);
imXk0 = imag(Xk0);

xk1 = cos(omega1*k);
Xk1 = fft(xk1);
magXk1 = abs(Xk1);
argXk1 = angle(Xk1);
reXk1 = real(Xk1);
imXk1 = imag(Xk1);

figure
subplot(2,2,1)
plot(reXk0)
title('Real Part of Xk0')

subplot(2,2,2)
plot(reXk1)
title('Real Part of Xk1')

subplot(2,2,3)
plot(imXk0)
title('Imaginary Part of Xk0')

subplot(2,2,4)
plot(imXk1)
title('Imaginary Part of Xk1')

figure
subplot(2,2,1)
plot(magXk0)
title('Magnitude of Xk0')

subplot(2,2,2)
plot(magXk1)
title('Magnitude of Xk1')

subplot(2,2,3)
plot(argXk0)
title('arg of Xk0')

subplot(2,2,4)
plot(argXk1)
title('arg of Xk1')

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

% % solution using spectrogram:
% 
% load('distorted')
% figure
% spectrogram(x, kaiser(800), 400, 800, 8000)
%% Exercise 3.5
load('voice2.mat');
l = size(voice2,1);
fs = 8000;
t = 0 : 1/fs : l-1/fs;
figure
spectrogram(voice2,blackman(l),100,200,fs,'yaxis');

ap = audioplayer(voice2, fs);
%play(ap);