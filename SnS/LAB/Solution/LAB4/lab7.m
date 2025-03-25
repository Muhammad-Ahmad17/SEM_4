clc; clear; close all;

% Define time range
t = -10:0.01:10;  % Time vector from -10 to 10

% Define input signal x(t)
x = cos(2 * pi * t);  % Bounded input

% System 1: y1(t) = x^2(t)
y1 = x.^2;

% System 2: y2(t) = t * x(t)
y2 = t .* x;

% Plot the input signal x(t)
figure;
subplot(3,1,1);
plot(t, x, 'b', 'LineWidth', 1.5);
grid on;
title('Input Signal x(t) = cos(2\pi t)');
xlabel('Time (t)');
ylabel('x(t)');

% Plot the output of System 1
subplot(3,1,2);
plot(t, y1, 'r', 'LineWidth', 1.5);
grid on;
title('Output of System 1: y_1(t) = x^2(t)');
xlabel('Time (t)');
ylabel('y_1(t)');

% Plot the output of System 2
subplot(3,1,3);
plot(t, y2, 'g', 'LineWidth', 1.5);
grid on;
title('Output of System 2: y_2(t) = t \cdot x(t)');
xlabel('Time (t)');
ylabel('y_2(t)');

% Conclusion: y1(t) remains bounded -> Stable ?
%             y2(t) grows unbounded -> Unstable ?
