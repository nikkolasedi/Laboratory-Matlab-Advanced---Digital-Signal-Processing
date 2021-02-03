% This script serves as a template for the experiment 'Spatial Signal Processing'
% Of course, other program structure that is different from this template
% could also be used. However, we strongly recommend you to use the given
% template

% Hint : The places marked by YOUR_CODE should be replaced or fulfilled by your own code
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------------------------------------------------------------------
%  (c) 2019 - RWTH Aachen University
% --------------------------------------------------------------------------
%  Version history:
%  1.0 - initial version - Maximilian Kentgens (kentgens@iks.rwth-aachen.de)
% --------------------------------------------------------------------------

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXCERCISE 1.1 & 1.3 %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Steering directions
theta1 = 90*pi/180;
phi1   = 45*pi/180;

theta2 = 90*pi/180;
phi2   = -45*pi/180;

direction1 = Direction(theta1,phi1);
direction2 = Direction(theta2,phi2);

direction1.plot;
figure;
direction2.plot;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXCERCISE 1.2 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load signal

hoaSig = HoaSignal('scene_HOA_O4_N3D_12k.wav'); % scene_HOA_O4_N3D_12k [(90,45) (90,-45)], signal_HOA_O4_N3D_12k [(100,42) (100,-30)]

%% Create easy omni-directional beamformer

% YOUR CODE HERE %

% sigOmni = ...
sigOmni = hoaSig.sigCoeffTime(:,1);
% END YOUR CODE HERE %

% You may listen to the the beamformer signals using the following
% commands:
%   soundsc(sigOmni,hoaSig.fs)
%   clear sound
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXCERCISE 1.4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create beamformedSignal for specified directions

beamformer = hoaSig.getBeamformer();

% YOUR CODE HERE % 

% sigBf1 = ...
sigBf1 = beamformer.beamformSignal(hoaSig,direction1);


% sigBf2 = ...
sigBf2 = beamformer.beamformSignal(hoaSig,direction2);
% END YOUR CODE HERE %
%sigTest = beamformer.beamformSignal(hoaSig,[direction1,direction2]);
%% Plot beamformer signals

% YOUR CODE HERE % 
figure
plot(sigBf1);
title('Beamformer (90°, 45°)')
figure
plot(sigBf2);
title('Beamformer (90°, -45°)')

% END YOUR CODE HERE %

% You may listen to the the beamformer signals using the following
% commands:
%   soundsc(sigBf1,hoaSig.fs)
%   soundsc(sigBf2,hoaSig.fs)
%   soundsc(sigOmni,hoaSig.fs)
%   clear sound

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXCERCISE 1.5 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Steered response power map

numAzim = 160;
numIncl = 80;
srpMap = hoaSig.getSteeredResponsePowerMap(numAzim,numIncl);

%% Iterate over frames, calculate and plot steered response power map

frameLength = 2048;
frameAdvance = 1024;

nFrames = floor((hoaSig.numSamples-frameLength)/frameAdvance+1);%92 number of frames @ 2048 overlap 1024
srpMap.initPlot();
for idxFrame = 1:nFrames % loop over all signal frames
    sampleRange = (idxFrame-1)*frameAdvance+(1:frameLength)'; % current sample range
       
    %% Calculate steered response power map for current sample range
    
    srpMap.generateSrpMap(hoaSig, sampleRange);
    srpMap.updatePlot();
    srpMap.markMaximum();

end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXCERCISE 1.6 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create BinauralRenderer for specified HRIR database

renderer = hoaSig.getBinauralRenderer('hrirs_12k.mat');
binauralSig = renderer.renderSignal(hoaSig);

%% Play binaural signal

sound(binauralSig,renderer.fs);
