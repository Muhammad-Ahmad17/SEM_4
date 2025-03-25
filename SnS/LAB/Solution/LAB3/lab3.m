clc;
clear;
close all;

% Define time vectors
t_causal = 0:0.1:5;       % Time for causal signal
t_anticausal = -5:0.1:0;  % Time for anti-causal signal
t_noncausal = -5:0.1:5;   % Time for non-causal signal

% Compute signals
x_causal = t_causal .* exp(-t_causal);
x_anticausal = t_anticausal .* exp(t_anticausal);
x_noncausal = t_noncausal .* exp(-abs(t_noncausal));

% Plotting
figure;

subplot(3,1,1)
plot(t_causal, x_causal, 'b', 'LineWidth', 1.5)
title('Causal Signal')
xlabel('t')
ylabel('x(t)')
grid on

subplot(3,1,2)
plot(t_anticausal, x_anticausal, 'r', 'LineWidth', 1.5)
title('Anti-Causal Signal')
xlabel('t')
ylabel('x(t)')
grid on

subplot(3,1,3)
plot(t_noncausal, x_noncausal, 'g', 'LineWidth', 1.5)
title('Non-Causal Signal')
xlabel('t')
ylabel('x(t)')
grid on
