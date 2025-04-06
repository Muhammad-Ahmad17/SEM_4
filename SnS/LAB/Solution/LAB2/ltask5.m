clc;
clear;
close all;
T = (2/3);            % Fundamental period
t= 0:0.001:4*T;
x=3*cos(3*pi*t +pi/3)

% Plot the signal
figure;
plot(t, x, 'b', 'LineWidth', 2);
xlabel('Time (t)');
ylabel('x(t)');
title('Four Periods of 3 cos(3\pi t + \pi/3)');
grid on;



% unfiltered

clc
clear
close all

w = 3 * pi ;
T = 2 * pi / w ;
t = linspace (0 , 4*T , 100);

x = 3 * cos (3*pi*t + pi/3 )

plot (t, x)
