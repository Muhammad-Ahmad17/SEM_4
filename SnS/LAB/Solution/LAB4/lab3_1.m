clc; clear; close all;

t = -3:0.1:3; % Time vector
x1 = heaviside(t) - heaviside(t-2); % Input signal x1(t)
x2 = heaviside(t) - heaviside(t-2); % Define a second input x2(t)

% Define arbitrary scalars for checking linearity
a1 = 2; 
a2 = 3;
% Nonlinear System: y(t) = x^2(t)
y2_combined = 2.^(a1*x1 + a2*x2); % Applying system on combined input
y2_individual = a1 * (x1.^2) + a2 * (x2.^2); % Applying system separately

% Plot results for System 2
figure;
subplot(2,1,1);
plot(t, y2_combined, 'r', ' LineWidth', 2);
title('System 2: y = x^2 Applied to Combined Input');
ylim([-1 11]); grid on;

subplot(2,1,2);
plot(t, y2_individual, 'b--', 'LineWidth', 2);
title('System 2: y = x^2 Applied to Individual Inputs then Added');
ylim([-1 11]); grid on;










t = -3:0.1:3; 
x1 = heaviside(t) - heaviside(t-2); 
x2 = heaviside(t) - heaviside(t-2); 
a1 = 2; 
a2 = 3;
y2_combined = 2.^(a1*x1 + a2*x2); 
y2_individual = a1 * (x1.^2) + a2 * (x2.^2);
	figure;
subplot(2,1,1);
plot(t, y2_combined, 'r', ' LineWidth', 2);
title('System 2: y = x^2 Applied to Combined Input');
ylim([-1 11]); grid on;

subplot(2,1,2);
plot(t, y2_individual, 'b--', 'LineWidth', 2);
title('System 2: y = x^2 Applied to Individual Inputs then Added');
ylim([-1 11]); grid on;