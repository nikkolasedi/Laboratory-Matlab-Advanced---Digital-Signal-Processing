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

y = S(:,1) + 1/N * sum(Noise')';   % no more than one line!
s_bar = S/N;
s_bar = sum(s_bar');
v_bar = Noise/N;
v_bar = sum(v_bar');

% saving WAV-Files

audiowrite( 'noisy_signal.wav', (Noise(:,1) + S(:,1))', fs )   % noisy signal
audiowrite( 'filtered_signal.wav', s_bar+v_bar, fs )   % filtered Signal

% listen to signals
% sound((Noise(:,1) + S(:,1))') % noisy signal
% sound(s_bar+v_bar) % filtered signal

% plot the spectrogram

figure
subplot(1,2,1)
% clf

spectrogram((Noise(:,1) + S(:,1))',250,200,200,8e3,'yaxis'); %spectrogram(x,window,noverlap,nfft,fs)
yt = get(gca, 'YTick')
set(gca, 'YTick',yt, 'YTickLabel',yt*1E+3)
title('Noisy speech signal')
ylabel('Frequency(Hz)')




subplot(1,2,2)
% clf

spectrogram(s_bar+v_bar,250,200,200,8e3,'yaxis');
yt = get(gca, 'YTick')
set(gca, 'YTick',yt, 'YTickLabel',yt*1E+3)
ylabel('Frequency(Hz)')

title('Filtered speech signal')

% no delay compensation since ideal estimation of theta_0 is assumed =>
% microphones can be aligned with desired signal => no delay since useful
% signal arrives simultaneously at all microphones 

% auditory impression: noise was reduced but desired signal seems as loud
% as before

% angles: speech signal: theta = (0.5 + k ) * pi, k is an integer (since no
% delay)

k_s = xcorr(S(:,1), S(:,8));
k_s = ks(ks == max(k_s));
tau_s = k_s/(7*fs);
angs = acos(tau_s);

k_n = xcorr(Noise(:,1), Noise(:,8));
k_n = find(max(k_n));
tau_s = k_n/(7*fs);
angs = acos(tau_s);

%% Exercise 9.2

s = S(:,1);
v_r = Noise(:,1);
a = scale4snr(s, v_r, SNR);
M = 250;

 C_F = length(s)/M;
 
 SNR_out = SNR;
 for i = 1:length(a)
     SNR_out(i) = 10*log10(sum(s_bar.^2)./sum(a(i)^2*v_bar.^2));
     for L = 0:239
     
         NA(i,L+1) = 1/C_F * sum(a(i)^2*v_r(L*M+1:(L+1)*M).^2)/sum(a(i)^2*v_bar(L*M+1:(L+1)*M).^2);
     
     end
 end
 
 NA = 10*log10(sum(NA'));
figure
subplot(1,2,1)
plot(SNR, SNR_out)
xlabel('Input SNR')
ylabel('Output SNR')

subplot(1,2,2)
plot(SNR, NA)
xlabel('Input SNR')
ylabel('Noise Attenuation')

%% Exercise 9.3
s = S(:,1);
v_r1 = Noise_w(:,1);
a1 = scale4snr(s, v_r1, SNR);
M = 250;

C_F1 = length(s)/M;

 SNR_out1 = SNR;
 for i = 1:length(a)
     vfilt = 1/8 * sum(a1(i) * Noise_w,2);
     SNR_out1(i) = 10*log10(sum(s.^2)./sum(vfilt.^2)); 
%      SNR_out1(i) = 10*log10(sum(s_bar.^2)./sum(a1(i)^2*v_bar.^2));
     for L = 0:239
           NA1(i,L+1) = 1/C_F1 *sum( a1(i)^2*v_r1(L*M+1:(L+1)*M).^2)/sum( vfilt(L*M+1:(L+1)*M).^2);
%          NA1(i,L+1) = 1/C_F1 *sum( a1(i)^2*v_r(L*M+1:(L+1)*M).^2)/sum( a1(i)^2*v_bar(L*M+1:(L+1)*M).^2);
     
     end
 end
NA1 =  10*log10(sum(NA1'));
figure
subplot(1,2,1)
plot(SNR, SNR_out1)
xlabel('Input SNR')
ylabel('Output SNR')

subplot(1,2,2)
plot(SNR, NA1)
xlabel('Input SNR')
ylabel('Noise Attenuation')

%% Exercise 9.4
theta = [0, 30, 60, 90]*pi/180; % incident angle in rad
% theta = [90, 120, 150, 180]*pi/180;
SNR2 = 0; % dB



%dist = [0:d:(N-1)*d];
%tau = zeros(N, length(theta));
tau = zeros(N, length(theta));

[y2,fs2] = audioread('autonoise.wav');
%y2_del = zeros(length(theta),N,80000);
a2 = scale4snr(s,y2 , SNR2);
%temp = zeros(1,80000);


% for n = 1:N
%     tau(n,:) = dist(n)*cos(theta)/c;
% end


tau = d*cos(theta)/c;


% for i = 1:length(theta)
%     for n = 1:N
%     temp = frac_del(y2',tau(n,i));
%         for j = 1:length(temp)
%         y2_del(i,n,j) = temp(j);
%         end
%     end
% end

% figure
% for i = 1:length(theta)
% for n = 1:N
%     subplot(N,length(theta),(i-1)*8+n)
%     plot(reshape(y2_del(i,n,:),1,2*length(y2)));
% end
% end

% figure
% for i = 1:length(theta)
% 
%     subplot(1,length(theta),i);
%     plot(reshape(1/N*sum(y2_del(i,:,:)),1,80000));
% 
% end


%n_theta = [1:4];
s = S(:,1);

%v_bar1_hat = zeros(4,80000);

% for k = 1:4
%   v_bar1_hat(k,:) = reshape(1/N*sum(y2_del(n_theta(k),:,:)),1,80000);  
% end
%v_bar1 = v_bar1_hat(:,1:length(y2));

%For segmental SNR
M = 256;
C_F2 = length(y2)/M;

scaled_no = a2 * y2;

SNR_out1 = zeros(1,4);

 for i = 1:length(theta)
     tau = dist*cos(theta(i))/c;
     %average noise of all mic
     v_bar2 = sum(frac_del(scaled_no,tau)/8,1);
     %noise reference mic
     v_r1 = frac_del(scaled_no,tau);
     v_r2 = v_r1(1,:);
     SNR_out1(i) = 10*log10(sum(s.^2)./sum(v_bar2.^2));
     temp = 0;
    
     for L = 0:C_F2-1
        
         %NA1(i,L+1) = 1/C_F2*sum(v_r2(L*M+1:(L+1)*M).^2)/sum( v_bar2(L*M+1:(L+1)*M).^2);
          temp = temp + sum(v_r2(L*M+1:(L+1)*M).^2)/sum( v_bar2(L*M+1:(L+1)*M).^2);
     end
     NA1(i) =  10*log10(temp/C_F2);

 end
 


figure
subplot(1,2,1)
plot(theta*180/pi, SNR_out1)
xlabel('theta')
ylabel('Output SNR')
set(gca, 'XTick', [0 30 60 90])

subplot(1,2,2)
plot(theta*180/pi, NA1)
xlabel('theta')
ylabel('Noise Attenuation')
set(gca, 'XTick', [0 30 60 90])


