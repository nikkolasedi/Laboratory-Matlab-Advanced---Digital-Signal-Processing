%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXCERCISE 1.4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef Beamformer < handle
    
    properties (GetAccess = public)
        
        hoaOrder; % HOA order
        directions; % steering directions of the beamformer
        ShMatrix; % spherical harmonics matrix corresponding to the steering directions
        
    end
    
    methods
        
        function obj = Beamformer(hoaOrder)
            
            if nargin >= 1
                obj.hoaOrder = hoaOrder;
            end
        end
        
        % YOUR CODE HERE.
        function X = beamformSignal(obj, hoaSignal, direction, sampleRange)
            
        % Implement beamformSignal method here
        obj.directions = direction;
        obj.ShMatrix = createSphericalHarmonicsMatrixFromDirection(obj);
        
%         assert(isa(hoaSignal,'HoaSignal'));
        if(nargin==4)
            X = obj.ShMatrix*transpose(hoaSignal.sigCoeffTime(sampleRange,:));
        else
            X = obj.ShMatrix*transpose(hoaSignal.sigCoeffTime);
        end
        
        end
        
        % END YOUR CODE HERE.
        
    end
    
    methods (Access = private)
        
        function Y = createSphericalHarmonicsMatrixFromDirection(obj) % Creates the Spherical Harmonics Matrix for the directions given in the Direction object obj.direction
            % Parameter handling.
            assert(isa(obj.directions,'Direction'));
            
            direction = obj.directions(:);
            Y = createSphericalHarmonicsMatrix(obj, [direction.theta]', [direction.phi]');
        end
        
        function Y = createSphericalHarmonicsMatrix(obj,theta,phi)
        % createSphericalHarmonicsMatrix creates a spherical harmonics matrix
        %
        %   Input arguments:
        %       theta  Column vector of inclination angles in radians
        %       phi    Column vector of azimuth angles in radians
        %
        %   Normalization is N3D.
        %
        %   Y =
        %                        n = 0                      n = 1                                    n = N
        %                    /------------\  /---------------------------------------------\  ... --------------\
        %
        %       gamma_1   /  Y_0^0(gamma_1)  Y_1^-1(gamma_1)  Y_1^0(gamma_1)  Y_1^1(gamma_1)  ...  Y_N^N(gamma_1)  \
        %       gamma_2   |  Y_0^0(gamma_2)  Y_1^-1(gamma_2)  Y_1^0(gamma_1)  Y_1^1(gamma_1)  ...  Y_N^N(gamma_2)  |
        %       gamma_3   |  Y_0^0(gamma_3)  Y_1^-1(gamma_3)  Y_1^0(gamma_1)  Y_1^1(gamma_1)  ...  Y_N^N(gamma_3)  |
        %         ...     |     ...             ...              ...             ...          ...     ...          |
        %       gamma_Q   \  Y_0^0(gamma_Q)  Y_1^-1(gamma_Q)  Y_1^0(gamma_1)  Y_1^1(gamma_1)  ...  Y_N^N(gamma_Q)  /
        %
        %--------------------------------------------------------------------------
        % (c) 2019 - RWTH Aachen University
        %--------------------------------------------------------------------------
        % Version history:
        % 1.0 - initial version - Maximilian Kentgens (kentgens@iks.rwth-aachen.de)
        %--------------------------------------------------------------------------
            %%
            N = obj.hoaOrder;
            Q = numel(theta);
            K = (N+1)^2;
            
            %%
            Y = zeros(Q,K);
            for n=0:N
                %% normalization constant
                F = sqrt( (2*n+1)/(4*pi) );
                
                %% Legendre part
                P_pos = bsxfun(@times, legendre(n,cos(theta(:))), ...
                    sqrt(factorial(n-(0:n)')./factorial(n+(0:n)')) );
                % MATLAB uses the Condon-Shortley-Phase in legendre!
                % Cancel the Condon-Shortley-Phase which is a term (-1)^m
                % More details:
                % http://mathworld.wolfram.com/Condon-ShortleyPhase.html
                P_pos = P_pos .* ( (-1).^(0:n)'*ones(1,Q) );
                % negative m
                P_neg = P_pos(end:-1:2,:) ;
                % all together
                P = [P_neg; P_pos];
                
                %% trigonometric part
                mx = (-n:n)';
                R =   (mx>0)  * ones(1,Q) .* cos(abs(mx)*phi(:)') * sqrt(2) ...
                    + (mx<0)  * ones(1,Q) .* sin(abs(mx)*phi(:)') * sqrt(2) ...
                    + (mx==0) * ones(1,Q) ;
                
                %% total spherical harmonics
                acnx = n.^2+n+(-n:n);
                Y(:,acnx+1) = F .* P' .* R';
            end
            
        end
    end
end

