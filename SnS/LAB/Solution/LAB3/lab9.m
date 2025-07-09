clc;
clear;
close all;

t = -1:0.01:3;
x_t = t .* exp(-t); % Original signal x(t)
% Time compression (a = 2): x1(t) = x(2t)
x1_t = (2*t) .* exp(-2*t); % *2 with t 
% Time expansion (a = 0.5): x2(t) = x(0.5t)
x2_t = (0.5*t) .* exp(-0.5*t); % *0.5 with t
% Plot the original and scaled signals
figure;
subplot(311);
plot(t, x_t);
title('Original Signal x(t)');
subplot(312);
plot(t, x1_t);
title('Time-Compressed Signal (x(2t))');
subplot(313);
plot(t, x2_t);
title('Time-Expanded Signal (x(0.5t))');

