clc; clear; close all;

t = -3:0.1:3; % Time vector
x1 = heaviside(t) - heaviside(t-2); % Input signal x1(t)
x2 = heaviside(t) - heaviside(t-2); % Define a second input x2(t)

% Define arbitrary scalars for checking linearity
a1 = 2; 
a2 = 3;

% Linear System: y(t) = 2x(t)
y1_combined = 2 * (a1*x1 + a2*x2); % Applying system on combined input
y1_individual = a1 * (2*x1) + a2 * (2*x2); % Applying system separately

% Plot results for System 1
figure;
subplot(2,1,1);
plot(t, y1_combined, 'r', 'LineWidth', 2);
title('System 1: y = 2x Applied to Combined Input');
ylim([-1 11]); grid on;

subplot(2,1,2);
plot(t, y1_individual, 'b--', 'LineWidth', 2);
title('System 1: y = 2x Applied to Individual Inputs then Added');
ylim([-1 11]); grid on;
