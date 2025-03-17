clc;
clear;
close all;

t = -1:0.1:3;

% Define the original signal x(t)
x_t = t .* exp(-t);

% Define the time-reversed signal x(-t)
x_neg_t = (-t) .* exp(t);

% Plot both signals
figure;
subplot(211);
plot(t, x_t, 'b', 'LineWidth', 2);
xlabel('t'); ylabel('x(t)');
title('Original Signal x(t)');
grid on;

subplot(212);
plot(t, x_neg_t, 'r', 'LineWidth', 2);
xlabel('t'); ylabel('x(-t)');
title('Time-Reversed Signal x(-t)');
grid on;
