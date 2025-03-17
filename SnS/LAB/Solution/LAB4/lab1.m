clc
close all
clear

t=-5:.01:5;
%system is dynamic or static
x=heaviside(t) - heaviside(t-1); % u(t)-u(t-1)
plot(t,x);

%static

hold on 
y1= 3*x;
plot(t,y1);
legend('x(t)','y1(t)');
ylim([0 4])

% vector concatination
clc;
close all;
clear;

t = -5:0.01:5;

% Define the Heaviside function values separately
u_t = heaviside(t);
u_t1 = heaviside(t - 1);

% Concatenate vectors for x(t) = u(t) - u(t-1)
x = [u_t - u_t1];

% Concatenate vectors for y1(t) = 3 * x(t)
y1 = [3 * x];

% Plot the original signal
plot(t, x, 'LineWidth', 2);
hold on;

% Plot the scaled signal
plot(t, y1, 'LineWidth', 2);

% Labels and legend
legend('x(t)', 'y1(t)');
ylim([0 4]);
grid on;
xlabel('t');
ylabel('Amplitude');
title('Heaviside Step Function with Scaling');


