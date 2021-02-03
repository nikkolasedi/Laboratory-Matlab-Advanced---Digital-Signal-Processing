% This script serves as a template for the fifth experiment 'Adaptive filtering'
% Of course, other program structure that is different from this template
% could also be used. However, we strongly recommend you to use the given
% template

% Hint : The places marked by YOUR_CODE should be replaced or fulfilled by your own code
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose the exercise that you wish to execute, this leads to different
% program branches below.

exercise = 2;                   % Number of exercise (1-7)

%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parameters and variables for the simulation ('Default-Values')
load echokomp                 % Room impulse response: g (cell array)
                              % Speech signal: s (vector)
alpha = 0.1;                  % Step size for NLMS

Ls = length(s);               % Length of the speech signal
n0 = sqrt(0.16)*randn(Ls,1);  % White noise
Vn = 3;                       % Number of curves in each plot (should not be changed)
noise = zeros( Ls, Vn );      % Disturbance caused by the near speaker and
                              % background noise
alphas = alpha*ones( Vn, 1);  % Step size factor for different exercises
Mh = length( g{1,1} ) * ones(Vn,1); % Length of the compensation filter

x = [ n0, n0, n0 ];           % white noise as input signal


% In the following part, the matrices and vectors must be adjusted to
% meet the requirement for different exercises
% (Exercise 1 can be simulated using only the initialized values above)

switch exercise

    case 2
        % Only the value of input speech signal need to be changed. All the other
        % vectors and parameters should not be modified

        x(:,1) = s;                  % Speech signal
        x(:,2) = n0;         % white noise
        x(:,3) = filter(1, [1, -0.5], n0);         % colorful noise

        %YOUR_CODE
        figureTitle = 'Different Input Signals';
        
    case 3

        noise(:,1) = zeros(Ls,1);
        noise(:,2) = sqrt(0.001)*randn(Ls,1);
        noise(:,3) = sqrt(0.01)*randn(Ls,1);
        
        %YOUR_CODE
        
    case 4

        x(:,1) = s;
        x(:,2) = s;
        x(:,3) = s;
        
        noise(:,1) = zeros(Ls,1);
        noise(:,2) = sqrt(0.001)*randn(Ls,1);
        noise(:,3) = sqrt(0.01)*randn(Ls,1);


    case 5

        noise(:,1) = sqrt(0.01)*randn(Ls,1);
        noise(:,2) = sqrt(0.01)*randn(Ls,1);
        noise(:,3) = sqrt(0.01)*randn(Ls,1);

        alphas = [0.1; 0.5; 1];
        
    case 6

        Mh = length( g{1,1} ) * ones(Vn,1) + [-10;-30;-60] ;

    case 7

        Mh(1) = length( g{1,1} );
        Mh(2) = length( g{1,2} );
        Mh(3) = length( g{1,3} );

end

figure(exercise)
clf

% There should be appropriate legends and axis labels in each figure!!

if exercise == 1

    [ sdiff, e, x_h, x_t ] =  nlms4echokomp( n0 , g{1,1}, zeros(Ls,1), ...
        alpha,  200  );

    %YOUR_CODE
    erle = zeros(length(x_t),1);
    for I = 1:length(x_t)-length(g{1,1})
        erle(I) = mean(x_t(I:I+length(g{1,1})-1).^2)/mean(e(I:I+length(g{1,1})-1).^2);
    end
    erle = 10*log10(erle);
    
    subplot(1,3,1)
    plot(x_t)
    hold on
    plot(e)
    legend('x_t','e')
    title('Echo signal x_t and residual echo e')
    xlabel('k')
    ylabel('Amplitude')
    
    subplot(1,3,2)
    plot(sdiff);
    title('Relative system distance in dB')
    xlabel('k')
    ylabel('D(k) / dB')
    
    subplot(1,3,3)
    plot(erle)
    title('ERLE')
    xlabel('k')
    ylabel('ERLE / dB')
else

    hold on
    col=[ ' -b' ; '-.r'; '--k' ];  % Line-Style

    for i=1:Vn
        %% 3 system distances with different parameters are calculated here

        if exercise == 7
            gi = g{1,i};
        else
            gi = g{1,1};
        end

        % The input variables of 'nlms4echokomp' must be adapted according
        % to different exercises. (see the 'switch' section above!)
        
        [ sdiff, e, x_h, x_t ] =  nlms4echokomp( x(:,i) , gi, noise(:,i), ...
            alphas(i),  Mh(i) );

        % Function 'nlms4echocomp' is not executable yet, please complete
        % this function first.
        
        plot( 0:(length( sdiff ) - 1) , sdiff , col(i,:), 'LineWidth', 2 );

        %YOUR_CODE
        if exercise == 2
            legend('speech signal', 'white noise', 'colorful noise');
        elseif exercise == 3 || exercise == 4
            legend('var = 0', 'var = 0.001', 'var = 0.01');
        elseif exercise == 5
            legend('alpha = 0.1', 'alpha = 0.5', 'alpha = 1');
        elseif exercise == 6
            legend('Mg = Mh - 10', 'Mg = Mh - 30', 'Mg = Mh - 60');
        else
            legend('Mg = 200', 'Mg = 1000', 'Mg = 2000');
        end

        
    end

    title( strcat('Versuch ',num2str(exercise),': ',figureTitle) );
    xlabel('k');
    ylabel(' D(k) / dB ');

    %YOUR_CODE


end