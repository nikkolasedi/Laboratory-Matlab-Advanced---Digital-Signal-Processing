% This m-script serves as a template for MATLAB Advanced experiment 10 concerning noise
% reduction using delay and sum beamformer.

% Hint : The places marked by ... should be replaced or completed by your own code
% This m-file is not yet executable!


% Parameter Setting
N = 8;        % Total number of microphones
d = 0.0425;   % Distance between adjacent microphones

fs = 8e3;          % sampling frequency
c = 340;           % sound velocity

dist = [0:d:(N-1)*d];  % Distances between the reference and all the other microphones


SNR = [-10:5:15];  % global SNRs in dB


% Load input signals for all the 8 microphones
% - Coherent noise
% - Uncorrelated white noise
% - Speech signal
load versuch_10

%% load versuch10_extra
%% versuch10_extra contains different noisy signals for further demonstration of noise reduction using DS BF (optional)


% Delay-and-sum beamforming
vr = sum((Noise(:,1).*Noise(:,1)));
vavg = sum((Noise(:,1).*Noise(:,1)))/size(Noise,1);
%y = ...  % no more than one line!
x = S + Noise;
y = sum(S,2)/size(S,1)+sum(Noise,2)/size(Noise,1);

% saving WAV-Files

audiowrite('sig_n.wav',x(:,1),fs)   % noisy signal
audiowrite('sig_f.wav',y,fs)   % filtered Signal

% Calculating angle of incident of noise
theta_deg_n = zeros(1,N-1);

for i = 2:N 
R = xcorr(Noise(:,1),Noise(:,i));
kn = size(Noise,1)-find(R == max(R));
theta = acos(kn*c/((i-1)*fs*d));
theta_deg_n(1,i-1) = theta/pi*180;
end

% Calculating angle of incident of speech
theta_deg_s = zeros(1,N-1);

for i = 2:N 
R = xcorr(S(:,1),S(:,i));
kn = size(S,1)-find(R == max(R));
theta = acos(kn*c/((i-1)*fs*d));
theta_deg_s(1,i-1) = theta/pi*180;
end

% plot the spectrogram

figure(1)
clf

spectrogram(x(:,1)')
    
title('Noisy speech signal')





figure(2)
clf
y1 = y';
spectrogram(y,'yaxis')

title('Filtered speech signal')


%% Exercise 9.2

SNR = [-10:5:15];
a = scale4snr(S,Noise, SNR);
i = [1:1:256];
NA = 0;
CF = 1;

for lamda = 1:floor(fs/256)
NA = NA + 10*log10(1/CF*sum((Noise(i,1).*Noise(:,1)))/



