clc
clear
close all

%1 continous
t1=-113:0.1:113
x1=cos(t1)

%2 discrete
n1=-113:0.1:113
x2=cos(n1)

% 3 digital
t = -113:113;   % Discrete time indices (integer steps)
x = cos(t);       % Compute the discrete values
round_x= round(x);

% Plot both on the same figure
subplot(311)
plot(t1, x1); 
axis([-10 10 -1 1])
subplot(312)
stem(n1, x2);
axis([-10 10 -1 1])
subplot(313)
stem(t, round_x); % Plot discrete signal
axis([-10 10 -1 1])

% Labels and title
xlabel('Time');
ylabel('Amplitude');
title('Comparison of CT vs DT');
grid on;



clc;
clear;
close all;

t = -113:113;   % Discrete time indices (integer steps)
x = cos(t);       % Compute the discrete values

figure;
stem(t, x, 'filled'); % Plot discrete signal
xlabel('n');
ylabel('x[n]');
title('Discrete-Time Cosine Signal');
axis([-10 10 -1 1])
grid on;