clc;
clear;
close all;

t = -113:113;   % Discrete time indices (integer steps)
x = cos(t);       % Compute the discrete values

figure;
stem(t, x, 'filled'); % Plot discrete signal
xlabel('n');
ylabel('x[n]');
title('Discrete-Time Cosine Signal');
axis([-10 10 -1 1])
grid on;
