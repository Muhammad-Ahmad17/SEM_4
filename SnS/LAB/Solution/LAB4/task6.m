clc; clear; close all;

% Define time range
t = -5:0.01:15;

% Define input signal x(t)
x = cos(t) .* (heaviside(t) - heaviside(t-10));

% Compute system output y(t) = 1 - 2x(t-1)
y = 1 - 2 * cos(t-1) .* (heaviside(t-1) - heaviside(t-11));

% Shift x(t) by 2 to get x(t-2)
x_shifted = cos(t-2) .* (heaviside(t-2) - heaviside(t-12));

% Compute the shifted output y(t-2)
y_shifted = 1 - 2 * cos(t-3) .* (heaviside(t-3) - heaviside(t-13));

% Compare y(t-2) with S[x(t-2)]
figure;
subplot(2,1,1);
plot(t, y_shifted, 'b', 'LineWidth', 1.5);
xlabel('t'); ylabel('y(t-2)');
title('Shifted Output y(t-2)');
grid on;

subplot(2,1,2);
plot(t, y, 'r', 'LineWidth', 1.5);
xlabel('t'); ylabel('S[x(t-2)]');
title('Output of Shifted Input S[x(t-2)]');
grid on;
