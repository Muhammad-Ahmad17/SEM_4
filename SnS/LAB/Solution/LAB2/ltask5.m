clc;
clear;
close all;
T = (2/3);            % Fundamental period
t= 0:0.001:4*T;
x=3*cos(3*pi*t +pi/3)

% Plot the signal
figure;
plot(t, x, 'b', 'LineWidth', 2);
xlabel('Time (t)');
ylabel('x(t)');
title('Four Periods of 3 cos(3\pi t + \pi/3)');
grid on;


