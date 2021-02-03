mex mexFlanger.c flanger.c 
[data , fs] = audioread('music.wav');

% How we call the function
out = mexFlanger(data, fs, 5, 0.7, 5, 0.2);
ap = audioplayer(out./max(out),fs); 
play(ap);
