clc; clear; close all;

% Define discrete-time index range
n = 0:5; 

% Given input signals
x1 = 0.8 .* n;    % x1[n] = 0.8n
x2 = cos(n);      % x2[n] = cos(n)

% Define arbitrary scalars
a1 = 2;
a2 = 3;

% Combined input signal
x_combined = a1*x1 + a2*x2;

% System 2: y[n] = n * x[n]
y2_combined = n .* x_combined; % Apply system to combined input
y2_individual = a1 * (n .* x1) + a2 * (n .* x2); % Apply system separately then add

% Plot results for System 2
figure;
subplot(2,1,1);
stem(n, y2_combined, 'r', 'LineWidth', 2); % Combined input
grid on;

subplot(2,1,2);
stem(n, y2_individual, 'b--', 'LineWidth', 2); % Individual inputs then add
grid on;
