%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXCERCISE 1.1 & 1.3 %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Example:
%   [phi,theta] = meshgrid([0,pi/2,pi,3*pi/2],[pi/3,2*pi/3]);
%   directionObj = Direction(theta,phi);
%   disp(directionObj);
%   figure; directionObj.plot();

% YOUR CODE HERE %

% implement the definition of the Direction class here...

% END YOUR CODE HERE %

classdef Direction 
    
    properties 
        theta
        phi 
         
    end
    
    methods
        
        function obj = Direction(theta,phi)
            if(nargin == 2)
            obj.theta = theta;
            obj.phi = phi;
            end
            
            
            
%         if isscalar(varargin{1}) 
%             if nargin > 1
%                 fprintf('Theta is equal to %f', varargin{1});
%                 obj.theta = varargin{1};
%                 fprintf('Phi is equal to %f', varargin{2});
%                 obj.phi = varargin{2};
%             elseif nargin > 0
%                 fprintf('Theta is equal to %f', varargin{1});
%                 obj.theta = varargin{1};
%                 fprintf('Phi is equal to %f', 1);
%                 obj.phi = 1;
%             else
%                 obj.theta = 1;
%                 obj.phi = 1;
%             end
%         else
%             
%                 [obj.theta, obj.phi] = arrayfun(@(x,y) Direction(x,y),varargin(1),varargin(2));
%                 obj(1,nargin) = obj;
%                 for i = 1:nargin
%                         obj(1,i).theta = varargin{i}.theta;
%                         obj(1,i).phi = varargin{i}.phi;
%                 end  
%            
%         
%         end
        end
        
        function thetaRad = getThetaInRadians(obj)
            fprintf('Getting value %f\n', obj.theta); 
            thetaRad = obj.theta;
        end
        function phiRad = getPhiInRadians(obj)
            fprintf('Getting value %f\n', obj.phi);
            phiRad = obj.phi;
        end
        function thetaRad = getThetaInDegrees(obj)
            fprintf('Getting value %f\n', obj.theta*180/pi);
            thetaRad = obj.theta*180/pi;
        end
        function phiRad = getPhiInDegrees(obj)
            fprintf('Getting value %f\n', obj.phi*180/pi);
            phiRad = obj.phi*180/pi;
        end
        function plot(obj)
            plot(obj.phi, obj.theta, 'x');
            % scatter(obj.phi, obj.theta);
        end
%         function setThetaInRadians(obj, newTheta)
%             fprintf('Explicitly setting theta to %f\n', newTheta);
%             obj.theta = newTheta;
%         end
    end
       
end
