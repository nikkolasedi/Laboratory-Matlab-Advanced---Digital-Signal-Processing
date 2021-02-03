
% This m-script serves as a template for MATLAB Advanced experiment 9 to
% plot the beam patterns of Delay-and-Sum Beamformers
%
% Hint : The places marked by .../??? should be replaced or completed by your own code
% This m-file is not yet executable!


% Simulation Parameters
% ==========================================

% General Parameters:

c = 340;        % Sound velocity
fs = 16e3;      % Sampling frequency

% Variables
N = 8;          % Number of sensors
d = 0.2;     % Distance between adjacent sensors
dist = [0:d:(N-1)*d];  % Distances to reference microphone


% Parameter for graphic representation of the beamformer
theta_0 = 0.5*pi;

% Please declare all the variables that you need for the implementation.
% The variables Bw and Bf are already given
% Please calculate the angles and frequencies with the help of these
% variables

Bw = 200;           % number of discrete angles
Bw2 = round(Bw/2);  % rounded for better legibility

angles = linspace(-pi,pi,Bw);  % Set of all angles (in Rad)
angles_deg = 180/pi*angles;    % ... in Deg

Bf = 128;           % Number of all the discrete frequency points
Bf2 = round(128/2); % rounded for better legibility

freq =linspace(0,fs/2,Bf2);   % Set of all discrete frequencies

epsi = 1e-10;       % (In order to avoid rounding errors)
th = -25;           % db-threshold for plots, for better graphic representation

% Calculating the directivity pattern
% =============================================================

% Calculating B(Omega)
coeff = zeros(Bf,N); 
for i = 1:N
  tau     = dist(i)/c*cos(theta_0)*fs;   
  arg     = -Bf2-tau+1:1:Bf2-tau+epsi; 
  coeff(:,i) = sinc( arg(1:Bf) );
end
B = 1/N*fft(coeff).'; 

for a = 1:Bw         % angle index
    
  for f = 1:Bf2       % frequency index
      
    % Calculating array-steering vector with dimension 1xN
    tau2 = dist/c*cos(angles(a));
    E = exp(1i*freq(f)*tau2*2*pi);

    
    % Calculating directivity pattern (Matrix dimension is Bf2xBw)
    
     Psi(f,a) = abs(sum(E*B(:,f))).^2;
     Psi_db(f,a) = 10*log10(Psi(f,a));
   
    if Psi_db(f,a) < th
        Psi_db(f,a) = th;  
    end  % Only for better graphic representation
    
  end
  
end
% Hint: Loops should generally be avoided in MATLAB and replaced by
% matrix operations. We used loops here only to help you to understand the
% calculation procedure.



% Plot the directivity pattern
% =============================================================


% 3 dimensional representation 
figure(1)
clf
surfc(angles_deg, freq, Psi_db)
xlabel('\theta/deg');
ylabel('f/Hz');
zlabel('\Psi(f, \theta/dB');

% ........???
view(150,60)

% 2 dimensional representation
figure(2)
clf
imagesc(angles_deg, freq, Psi_db)
xlabel('\theta/deg');
ylabel('f/Hz');
title('\Psi(f, \theta/dB');

% ........???
% main difference between broadside & endfire array: 
% - rotation among the z-axis by theta_0
% - peaks of the endfire array are not in the centre
% increase of sensor distance: more lobes
