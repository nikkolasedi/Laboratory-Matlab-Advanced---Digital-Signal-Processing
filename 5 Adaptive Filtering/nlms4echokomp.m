function [ sdiff , err, x_hat , x_tilde ] = nlms4echokomp( x, g, noise, alpha, Mh )
% The MATLAB function 'nlms4echokomp' simulates a system for acoustic echo compensation using
% NLMS algorithm
%
% [ sdiff , err, x_hat , x_tilde ] = nlms4echokomp( x, g, noise, alpha, Mh )
%     Input variables
%     x     : Input speech signal from far speaker
%     g     : impluse response of the simulated room
%     noise : Speech signal from the near speaker and the background noise(s + n)
%     alpha : Step size for the NLMS algorithm
%     Mh    : Length of the compensation filter
%
%     Output variables
%     sdiff   : relative system distance in dB
%     err     : error signal e(k)
%     x_hat   : output signal of the compensation filter
%     x_tilde : acoustic echo of far speakers

% Hint : The places marked by YOUR_CODE should be replaced by your own code

% Initialization of all the variables
Lx = length(x);   % Length of the input sequence
Mg = length(g);   % Length of the room impulse response(RIR)
if Mh > Mg
    Mh = Mg;
    warning('The compensation filter is shortened to fit the lenth of RIR!')
end

% Vectors are initialized to zero vectors.
x_tilde = zeros( Lx - Mg, 1 );  
x_hat   = x_tilde;          
err     = x_tilde;
s_diff  = x_tilde;
h       = zeros(Mh,1); % zeros(Mh,1);
% erle = x_tilde;

% Realization of NLMS algorithm
k = 0;  
for index = (Mg) : Lx
    k = k + 1;  % time index

    % Extract the last Mg values(including the current value) from the
    % input speech signal x, where x(i) represents the current value.
    xblock = x(k:k+Mg-1);
    xblock = xblock';

    % Filtering the input speech signal using room impulse response and
    % adaptive filter.
    % Please note that you don't need to implement the complete filtering
    % here
    % A simple vector manipulation would be enough here
    x_tilde(k) = xblock*g + noise(k);
    if Mh < Mg
        h = [h(1:Mh); zeros(Mg-Mh,1)];
    end
    x_hat(k)   = xblock*h;
      
    % Calculating the estimated error signal
    err(k) = x_tilde(k) - x_hat(k);
      
    % Updating the filter
    h = h + alpha/norm(xblock)^2*err(k)*xblock';
      
    % Calculating the relative system distance
    s_diff(k) = norm(g-h).^2/norm(g)^2;
    
%     % Calculating the ERLE measure
%     erle(k) = 10*log10(mean((xblock*g).^2)/mean((xblock*g-xblock*h).^2));
end

% Calculating the relative system distance in dB
sdiff = 10*log10( s_diff / 1 ); 
