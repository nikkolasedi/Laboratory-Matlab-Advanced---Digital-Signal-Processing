
% This m-script serves as a template for MATLAB Advanced experiment 9 to
% calculate the 'Array-Gains' and the 'White-Noise Gains' using Delay-and-Sum Beamformers
%
% Hint : The places marked by ... should be replaced or completed by your own code
% This m-file is not yet executable!

% Simulation parameters
% ==========================================

% general parameters:
c = 340;        % Sound velocity (m/s)
fs = 16e3;      % Sampling frequency

% Variables
N = 8;          % Number of sensors
d = 0.0425;     % Distance between adjacent sensors
% d = 0.20;

theta = pi/2;   % Array orientation broadside
% theta = 0;   % Array orientation broadside
dist = [0:d:(N-1)*d];  % Distances to reference microphone dim 8 

Bf = 128;                      % Number of discrete frequency points
Bf2 = round(Bf/2);              % 64
freq = [0:Bf2-1]/Bf*fs;        % Vector containing all the discrete frequency 64 points
epsi = 1e-10;                  % (in order to prevent from problems caused by rounding)

% Calculating the gains of DS Beamformers
% =============================================================

% Calculating B(Omega)
coeff = zeros(Bf,N); 
for i = 1:N
  tau      = dist(i)*cos(theta)/c*fs; %% theta?
  arg      =  -Bf2-tau+1:1:Bf2-tau+epsi; %% 128
  coeff(:,i) = sinc( arg(1:Bf) );
end
B = 1/N*fft(coeff).'; 

% Calculating Psi(Omega,theta0)
Psi = zeros(Bf2,1);

for f = 1:Bf2       % frequency index 128 vector
      
    % Calculating array-steering vector with dimension 1xN
    E = exp(1i*2*pi*freq(f)*dist*cos(theta)/c); 
    
    % Calculating directivity pattern (Matrix dimension is Bf2xBw)
    Psi(f) = (abs(sum(E*B(:,f)))).^2; 
 
end

arg = (2*freq*d/c).'; % Arguement for the sinc function of S
B = B.';

S = zeros(Bf2,1);
Swn = S;

for n=1:N
    
    %Denominator of Gwn
    Swn = Swn + (abs(B(1:64,n))).^2;
    
    for m=1:N
    
       %Denominator of G
       S = S + B(1:64,n).*conj(B(1:64,m)).*sinc(arg*abs(n-m));
        
    end
    
end

% Calculating Array Gain
G = 10*log10(Psi./S);

% Calculating White Noise Gain
Gwn =  Psi./Swn;


figure(5)
plot(freq,G)
ylabel('Gain / dB')
xlabel('f / Hz')
grid on
box on
title('Array Gain')

figure(6)
plot(freq,Gwn)
ylabel('Gwn')
xlabel('f / Hz')
grid on
box on
title('White Noise Gain')



