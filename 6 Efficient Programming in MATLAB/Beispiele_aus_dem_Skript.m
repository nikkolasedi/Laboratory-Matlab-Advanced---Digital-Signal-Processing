%% Effizientes Programmieren mit MATLAB
% Aufgabe 7.1
% Beispiele aus dem Skript

%% MATLAB Stopuhr
x = 0;
tic
for k = 1:1000
    x = x + k;
end
toc

%% Tic Toc Speichern
tall = tic;
x = 0;
for k=1:10
    tpart = tic;
    x = x+k;
    toc(tpart);
end
disp('Gesamtdauer:');
toc(tall);

%% Vektorisierung - Schleifen
t = 0:0.01:100;
s = rand(size(t));

for k = 1:length(t)
    A(1,k) = sin(t(k));
    A(2,k) = cos(t(k));
end

% multiplizieren
for k = 1:size(A,1)
    for l = 1:size(A,2)
        r(k,l) = A(k,l) * s(l);
    end
end

% quadrieren, addieren und Wurzel ziehen
for l = 1:size(r,2)
    result(l) = sqrt(r(1,l)^2 + r(2,l)^2);
end

%% Vektorisierung - Vektorisiert
t = 0:0.01:100;
s = rand(size(t));

A = [sin(t); cos(t)];
S = repmat(s,2,1);
result = sqrt(sum((A .* S).^2));

%% Speicher vorreservieren - nicht beachtet
x = 0;
tic;
for k = 2:100000
    x(k) = x(k-1) + 10;
end
toc

%% Speicher vorreservieren - beachtet
x = zeros(1,100000);
tic;
for k = 2:100000
    x(k) = x(k-1) + 10;
end
toc

