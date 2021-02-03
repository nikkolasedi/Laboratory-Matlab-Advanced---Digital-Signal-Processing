%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXCERCISE 1.2 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef HoaSignal < handle
    
    properties (GetAccess = public)
        
        sigCoeffTime; % Higher Order Ambisonics (HOA) signal
        hoaOrder; % HOA order
        fs; % Sampling rate
        numSamples; % Number of samples in HOA signal
        
    end
    
    methods
        
        function obj = HoaSignal(sFilename)
            
            % YOUR CODE HERE.
            
            % Implement constructor here
            [y,obj.fs] = audioread(sFilename);
            obj.sigCoeffTime = y;
            obj.numSamples = size(y,1);% Num of entries
            obj.hoaOrder =  sqrt(size(y,2))-1;% Sampling points
            
        end
            % END YOUR CODE HERE.
            
        
        
        function beamformer = getBeamformer(obj) % Provides a Beamformer object that fits to the current HoaSignal
            
            beamformer = Beamformer(obj.hoaOrder);
            
        end
        
        function binauralRenderer = getBinauralRenderer(obj, sFilenameHrir) % Provides a BinauralRenderer object that fits to the current HoaSignal
            
            binauralRenderer = BinauralRenderer(obj.hoaOrder, obj.fs, sFilenameHrir);
            
        end
        
        function steeredResponsePowerMap = getSteeredResponsePowerMap(obj, numAzimuths, numInclinations) % Provides a SteeredResponsePowerMap object that fits to the current HoaSignal
            
            steeredResponsePowerMap = SteeredResponsePowerMap(obj.hoaOrder, obj.fs, numAzimuths, numInclinations);
            
        end
        
    end
    
    
end

