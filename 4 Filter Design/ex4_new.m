% Exercise 4
close all;
%% Exercise 4.1

% Highpass
% Lowpass

%% Exercise 4.2
close all;
k = [1:1:16];
y01 = sin(pi/2*(k-8.5))./(pi/2*(k-8.5));


figure
% d_16 = fir1(16,0.5,rectwin(17));
freqz(1/10^(5.523/20)*y01.*rectwin(16)');
title('Rectangular Window 16');
% Min attenuation in stopband -22,65 dB
% Width of transition region (0.627-0,476)*pi=0.4744 Hz
% Maximum overshoot in passband 1,406 dB


k2 = [1:64];
y02 = sin(pi/2*(k2-32.5))./(pi/2*(k2-32.5));
figure;
freqz(1/10^(5.90002/20)*y02.*rectwin(64)');
title('Rectangular Window 64')
% Min attenuation in stopband -21,337 dB
% Width of transition region (0.5313-0.4935)*pi = 0.1188 Hz
% Maximum overshoot in passband 0,905 dB


figure;

freqz(1/10^(6.01096/20)*y02.*hamming(64)');
title('Hamming 64')
% Min attenuation in stopband -52,442 dB
% Width of transition region (0.5645-0.488)*pi = 0.2403  Hz
% Maximum overshoot in passband 0,022 dB


figure;

freqz(1/10^(6.02065/20)*y02.*blackman(64)');
title('Blackman 64')
% Min attenuation in stopband -75,28 dB
% Width of transition region (0.627-0.484)*pi = 0.4492 Hz
% Maximum overshoot in passband 0,001 dB

%% Exercise 4.3
Kaiser = load('Kaiser.mat');
Num = Kaiser.Kaiser.Numerator;
figure
plot(Num);
hold on;

%% Exercise 4.4 
M = max(Num);
m = min(Num);
r = max(Num)-min(Num);
Nums = Num-m;

Num2 = r/63*round(63*Nums/r)+m;
Num3 = r/3*round(3*Nums/r)+m;

figure;
plot(Num2);
hold on;
plot(Num3);
legend('64','4');

%% Exercise 4.5

a = [1]; %y
b = [1 -1]; %x

a = [1]; %y
b1 = [-1/12 8/12 0 -8/12 1/12]; %x

h_diff = impz(b,a,33);
h_stir = impz(b1,a,33);

f2 = [0 1];
a2 = [0 pi];
h_parks = firpm(32,f2,a2);

[h1,w1] = freqz(h_diff);
[h2,w2] = freqz(h_stir);
[h3,w3] = freqz(h_parks);
figure
plot(w1,abs(h1),w2,abs(h2),w3,abs(h3));
legend('h1','h2','h3')
%% Exercise 4.6
load('coef_ex4_6');
fvtool(butter, cheby1, cheby2)
legend('Butterworth', 'Chebyshev I', 'Chebyshev II');
%Takes at least time Butterworth -> Chebyshev I -> Chebyshev II
    
%% Exercise 4.7
b = [1 1]; %x
a = [1 -0.16]; %y

h_rec = impz(b,a);%Generate impulse response
% transfer function: H(z) = (1+0.16*z^-1)/(1+z^-1)
% low pass

figure;
freqz(b,a,10,500);
title('500 Hz');
figure;
freqz(b,a,10,1000);
title('1000 Hz');
figure;
freqz(b,a,10,1500);
title('1500 Hz');

%Sampling frequency & Cut-off frequency
%500 Hz -> 184 Hz
%1000 Hz -> 369 Hz
%1500 Hz -> 552 Hz
%linear relation between Sampling frequency & Cut-off frequency

%% Exercise 4.8
%yn = a*Q*yn-1 + xn-1

% case 1: no quantization
a = -0.92;
x1 = [10, zeros(1,99)];
y1 = zeros(1, 100);

for n = 1:99
    y1(n+1) = a*y1(n)+x1(n);
end

figure
plot(y1)
title('case 1: no quantization')

% case 2: rounding to closest integer
x2 = [10, zeros(1,99)];
y2 = zeros(1, 100);
for n = 1:99
    y2(n+1) = round(a*y2(n))+x2(n);
end

figure
plot(y2)
title('case 2: rounding to closest integer')

% case 3: word length reduction
x3 = [10, zeros(1,99)];
y3 = zeros(1, 100);
for n = 1:99
    y3(n+1) = floor(10*a*y3(n))/10+x3(n);
end

figure
plot(y3)
title('case 3: word length reduction')

% case 4a: without rounding
a4 = 0.92;
x4 = [10, zeros(1,99)];
y4 = zeros(1, 100);

for n = 1:99
    y4(n+1) = a4*y4(n)+x4(n);
end

figure
plot(y4)
title('case 4a: without rounding')

% case 4b: with rounding
x5 = [10, zeros(1,15)];
y5 = zeros(1, 16);

for n = 1:15
    y5(n+1) = round(a4*y5(n))+x5(n);
end

figure
plot(y5)
title('case 4b: with rounding')