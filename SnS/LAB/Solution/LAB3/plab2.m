% clc 
% clear
% close all
% 
% t1=0:.1:2;
% t2=2:.1:4;
% 
% x1=t1;
% x2=t2;


% flip > vector flip karta ha 
%- lagany say plot flip hota ha

clc; clear; close all;

% Define original piecewise function x(t)
t1 = 0:0.01:2;
x1 = t1;
t2 = 2:0.01:4;
x2 = 4 - t2;

% Full x(t)
t = [t1, t2];
x = [x1, x2];

% Define transformations
t_neg = -t;        % x(-t)
t_scale = t / 2;   % x(t/2)
t_shift_scale1 = (2 + 4*t);  % x(2 + 4t)
t_shift_scale2 = (-2 - 4*t); % x(-2 - 4t)

% Plot original signal x(t)
subplot(3,2,1);
plot(t, x, 'b', 'LineWidth', 2);
xlabel('t'); ylabel('x(t)');
title('Original Signal x(t)');
grid on;

% Plot x(-t) (Time reversal)
subplot(3,2,2);
plot(t_neg, x, 'r', 'LineWidth', 2);
xlabel('t'); ylabel('x(-t)');
title('Time-Reversed Signal x(-t)');
grid on;

% Plot x(t/2) (Time scaling)
subplot(3,2,3);
plot(t_scale, x, 'g', 'LineWidth', 2);
xlabel('t'); ylabel('x(t/2)');
title('Time-Scaled Signal x(t/2)');
grid on;

% Plot x(2 + 4t) (Time scaling and shifting)
subplot(3,2,4);
plot(t_shift_scale1, x, 'm', 'LineWidth', 2);
xlabel('t'); ylabel('x(2 + 4t)');
title('Scaled and Shifted Signal x(2 + 4t)');
grid on;

% Plot x(-2 - 4t) (Time reversal, scaling, and shifting)
subplot(3,2,5);
plot(t_shift_scale2, x, 'c', 'LineWidth', 2);
xlabel('t'); ylabel('x(-2 - 4t)');
title('Transformed Signal x(-2 - 4t)');
grid on;

% Adjust layout
sgtitle('Signal Transformations');
