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
plot(t, x_t, 'b', 'LineWidth', 2);
xlabel('t'); ylabel('x(t)');
title('Original Signal x(t)');
grid on;

subplot(312);
plot(t, x1_t, 'r--', 'LineWidth', 2);
xlabel('t'); ylabel('x(2t)');
title('Time-Compressed Signal (x(2t))');
grid on;

subplot(313);
plot(t, x2_t, 'g-.', 'LineWidth', 2);
xlabel('t'); ylabel('x(0.5t)');
title('Time-Expanded Signal (x(0.5t))');
grid on;
