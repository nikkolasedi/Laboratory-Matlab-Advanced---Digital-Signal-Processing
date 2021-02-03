%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXCERCISE 1.6 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef BinauralRenderer < Beamformer

    properties (GetAccess = public)
        
        hrirSet; % Set of Head-Related Impulse Responses (HRIRs) and corresponding directions
        fs; % Sampling rate
        
    end
    
    methods
        
        function obj = BinauralRenderer(hoaOrder, fs, sFilenameHrir)
            
            if nargin < 1
                hoaOrder = 4;
            end
            if nargin < 2 || isempty(fs)
                fs = 12e3;
            end
            if nargin < 3 || isempty(sFilenameHrir)
                sFilenameHrir = 'hrirs_12k.mat';
            end
            
            % YOUR CODE HERE %
            
            % implement the rest of the constuctor here...
            obj.hoaOrder = hoaOrder;
            obj.fs = fs;
            obj.hrirSet = load(sFilenameHrir, 'hrirs');
            ttheta = load(sFilenameHrir, 'theta');
            tphi = load(sFilenameHrir, 'phi');
            obj.directions = Direction(ttheta.theta(:),tphi.phi(:));
            % END YOUR CODE HERE %
            
        end
        
        function binauralSig = renderSignal(obj, hoaSignal)
            
            % YOUR CODE HERE %
            
            % implement the method renderSignal here...
            binauralSigL = 0;
            binauralSigR = 0;
            bfSig = obj.beamformSignal(hoaSignal, obj.directions);
            for i = 1: size(obj.hrirSet.hrirs)
                
            binauralSigL = binauralSigL + conv(obj.hrirSet.hrirs{i,1}(:,1), bfSig(i,:));
            binauralSigR = binauralSigR + conv(obj.hrirSet.hrirs{i,1}(:,2), bfSig(i,:));
            
            end
            binauralSig = [binauralSigL;binauralSigR];
            % END YOUR CODE HERE %
            
        end
    end
end

