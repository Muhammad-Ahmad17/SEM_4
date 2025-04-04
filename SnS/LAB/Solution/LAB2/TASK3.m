clc;
clear;
close all;
R=8;
T=R/2;

t=-6:0.1:6
p=heaviside(t+T/2)-heaviside(t-T/2)
plot(t,p)
axis([-8 8 -0.1 1.2])





% Define T based on Roll Number (Example: Roll Number = 20, then T = 10)
Roll_Number = 20;
T = Roll_Number / 2;
% Define time range
t = linspace(-T, T, 1000); % Covers a larger range to visualize the pulse
% Define the rectangular pulse using unit step functions
p_T = heaviside(t + T/2) - heaviside(t - T/2);
% Plot the rectangular pulse
figure;
plot(t, p_T, 'b', 'LineWidth', 2);
grid on;
xlabel('Time (t)');
ylabel('Amplitude');
title(['Rectangular Pulse Function for T = ', num2str(T)]);
ylim([-0.1, 1.1]); % Set y-axis limits for better visibility
