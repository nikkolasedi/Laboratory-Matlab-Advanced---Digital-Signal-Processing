%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXCERCISE 1.5 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef SteeredResponsePowerMap < Beamformer
    
    properties (GetAccess = public)
        
        hFig; % handle to figure of Steered Response Power Map (SRP) map
        fs; % Sampling rate of HOA signal that is plotted
        numSamples; % Number of samples of HOA signal that is plotted
      
    end
    
    properties (Access = private)
        
        srpMapData; % data of current SRP map
        idxLastSample; % index of last sample of current signal frame
        
        numAzimuths; % number of azimuth angles
        numInclinations; % number of inclination angles
        inclinationVec; % vector of inclination angles
        azimuthVec; % vector of azimuth angles
        azimuthGrid; % 2D grid of azimuth angles
        inclinationGrid; % 2D grid of inclination angles
        numDirections; % number of different directions
        
        hPlot; % handle to current plot
        hDoa; % handle to tracked maximum
        
    end
    
    
    methods
        
        function obj = SteeredResponsePowerMap(hoaOrder, fs, numAzimuths, numInclinations)
            
            if nargin < 1
                hoaOrder = 4;
            end
            
            if nargin < 2 || isempty(fs)
                fs = 12e3;
            end
                        
            obj@Beamformer(hoaOrder);
            
            obj.fs = fs;
            
            obj.inclinationVec = linspace(0,pi,numInclinations)';
            obj.azimuthVec     = linspace(-pi,pi,numAzimuths)';
            
            obj.numAzimuths = numAzimuths;
            obj.numInclinations = numInclinations;

            [obj.azimuthGrid,obj.inclinationGrid] = meshgrid(obj.azimuthVec,obj.inclinationVec);
          
            obj.directions = Direction( obj.inclinationGrid(:), obj.azimuthGrid(:) );
            obj.numDirections = numInclinations * numAzimuths;
            
        end
        
        function srpMapData = generateSrpMap(obj, hoaSignal, sampleRange)
            
            % Default parameters.
            if nargin < 2
                sampleRange = (1:hoaSignal.numSamples)';
            end
            
            obj.idxLastSample = sampleRange(end);
            obj.numSamples = hoaSignal.numSamples;
            
            % YOUR CODE HERE %
            
            % Implement the method generateSrpMap here...
            
            %size((obj.beamformSignal(hoaSignal,obj.directions,sampleRange)).^2)
            srpMapData = mean((obj.beamformSignal(hoaSignal,obj.directions,sampleRange)).^2,2);
            obj.srpMapData = srpMapData;
            
            % END YOUR CODE HERE %
            
        end
        
        function initPlot(obj)
            
            % Set up figure;
            obj.hFig = figure;
            obj.hPlot = imagesc(rad2deg(obj.azimuthVec),rad2deg(obj.inclinationVec),nan(obj.numInclinations,obj.numAzimuths));
            hold on;
            obj.hDoa  = scatter(0,0);
            set(gca, 'XDir','reverse');
            set(gca, 'YDir','reverse');
            colorbar;
            axis equal;
            axis tight;
            xlabel('azimuth [degree]');
            ylabel('inclination [degree]');
            
        end
        
        function updatePlot(obj)
            
            % YOUR CODE HERE %
            
            dataInDb = 10*log10(obj.srpMapData);
            
            % YOUR CODE HERE %
            
            obj.hPlot.CData(:) = dataInDb;

            title(sprintf('steered response power map\n time %.2f s / %2.f s', obj.idxLastSample / obj.fs , obj.numSamples  / obj.fs));
            colorbar;
            drawnow;
            
        end
        
        
        function markMaximum(obj)
            
            % YOUR CODE HERE %
            
            % Implement the maximum tracking here...
            [~,Y]=max(obj.srpMapData(:));
%           obj.hDoa = scatter(obj.inclinationGrid(Y)*180/pi,obj.azimuthGrid(Y)*180/pi,'o');
            obj.hDoa.XData = obj.azimuthGrid(Y)*180/pi;
            obj.hDoa.YData = obj.inclinationGrid(Y)*180/pi;
            drawnow;
            % YOUR CODE HERE %
            
        end
        
    end
end