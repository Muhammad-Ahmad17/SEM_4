clc;
clear;
close all;

t = -2 : .1 : 2;
x = sin(t);
T=2*pi;

for n = 1:5
       xn(n,:) = sin(t+n*T)
       figure
       plot(t,xn(n,:) )
end
%====================
clc;
clear;
close all;

t = -2 : .1 : 2;
x = t .* sin(t);  % Non-periodic signal

for n = 1:5
    xn(n,:) = x + n;  % Simply shifting the non-periodic signal
    figure;
    plot(t, xn(n,:));
end