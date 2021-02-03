%% Exercise 6.1

% See the script Examples_from_the_script.m

%% Exercise 6.2

%Choose ex to change the case
%Press Run and Time to see the required amount of time
ex = 4;
profile on
switch ex
    case 1
    %Small amounts of data
    decimal2binary(4);

    case 2
    %Large amounts of data
    decimal2binary(1:10000);
    
    case 3
    %Compare the previous and the accelerated function 
    %for small amounts of data
    decimal2binaryfast(4);
    decimal2binary(4);

    case 4
    %Compare the previous and the accelerated function 
    %for large amounts of data
    decimal2binaryfast(1:10000);
    decimal2binary(1:10000);
    otherwise
        
end
profile viewer

%% Exercise 6.3.1

%See the script channelsim.m

%% Exercise 6.3.2

%See the script channelsim.m
%Optional input 1 to set ratio E_b/N_0

%% Exercise 6.3.5

%See the script channelsim.m
%Optional input 2 to set code rate k/n

%% Exercise 6.3.3-6.3.4
filename = 'speech.wav';
[y,Fs] = audioread(filename);
err_t = zeros(1,25);

%Code modification
y_o = converter(y);

for j = 1:25
    
    y_t = channelsim(y_o,j,1);
        
    err = sum(sum(y_t ~= y_o));
    err_t(j) = err/(size(y_t,1)*size(y_t,2));
    
end

%Plot the bit error rate
plot(0:24,err_t);
set(gca, 'YScale', 'log');
xlim([0 24]);
grid on;
set(gca,'xminorgrid','on');
xlabel('ratio E_b/N_0 [dB]');
ylabel('Number of bit errors');
title('Graph of bit error rate over against ratio E_b/N_0');

%% Listen to audio

% np = 12; %noise power density
% y_t = channelsim(y_o,np,1);
% y_a = bi2de(flip(y_t,2))/2^15-1;
% sound(y_a,Fs);

%Don't hear any errors starting from 11/12 dB

%% Exercise 6.3.5-6.3.6

load('syntab.mat');

[parmat,genmat,k] = cyclgen(31,'1 + x + x^2 + x^3 + x^5 + x^7 + x^8 + x^9 + x^10 + x^11 + x^15');
%t = syndtable(parmat);
n = 16;
m = 31;

code = encode(y_o,m,k,'linear/binary',genmat);
err2_t = zeros(1,25);

for j = 1:25
    
    code2 = channelsim(code,j,n/m);

    msg = decode(code2,m,k,'linear/binary',genmat,syntab);
    err2 = sum(sum(msg ~= y_o));
    err2_t(j) = err2/(size(msg,1)*size(msg,2));
end

%Plot the bit error rate
figure;
plot(0:24, err_t);
hold on;
plot(0:24, err2_t);
set(gca, 'XTick', [3 6 9 12 15 18 21 24]);
xlim([0 24]);
set(gca, 'YScale', 'log');
xlabel('ratio E_b/N_0 [dB]');
ylabel('Number of bit errors');
legend('Without channel coding','With channel coding');
%Grid and minor grid on
grid on;
set(gca,'xminorgrid','on');
title('Graph of bit error rate over against ratio E_b/N_0');

%% Listen to audio

%     np = 9; %noise power density
%     
%     code2 = channelsim(code,np,16/31);
%     
%     msg = decode(code2,m,k,'linear/fmt',genmat,syntab);
%     y_a = bi2de(flip(msg,2))/2^15-1;
%     sound(y_a,Fs);

%Don't hear any errors starting from 8/9 dB

%% Exercise 6.7
% It's not always adventageous using channel coding. From ratio E_b/N_0 = 10
% dB using channel coding is no longer adventageous.

% Create an arrow

% hold on;
% set(gca, 'YScale', 'linear');
% p2 = [length(err_t)-1-sum(err_t == min(err_t))-6 err_t(length(err_t)-sum(err_t == min(err_t)))+0.000007];                         % First Point
% p1 = [length(err_t)-1-sum(err_t == min(err_t)) err_t(length(err_t)-sum(err_t == min(err_t)))];                         % Second Point
% dp = p2-p1; % Difference
% quiver(p1(1),p1(2),dp(1),dp(2),1,'Marker','x','LineStyle',':','LineWidth',2);
% set(gca, 'YScale', 'log');