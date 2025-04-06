clc;
clear;
close all;

% Time range for three periods
T = 2*pi; % Fundamental period
t = linspace(0, 3*T, 1000); % Fine time step

% Signal Definition
x_t = cos(t) + sin(3*t);

% Plot the signal
plot(t, x_t, 'b', 'LineWidth', 1.5);
xlabel('Time (t)');
ylabel('x(t)');
title('Plot of x(t) = cos(t) + sin(3t)');
grid on;