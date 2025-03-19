clc;
clear;
close all;



% 5 
clc;
clear;
close all;

syms t
t0 = 0;
T = 2;
w = 2*pi/T;

% Define x(t)
x = heaviside(t) - heaviside(t-1);
ezplot(x, [0 2]);
legend('x(t)')

% Approximation

figure
k = -2:2; % Using only 5 terms (-5 to 5)
a = (1/T) * int(x * exp(-j*k*w*t), t, t0, t0+T);
xx = sum(a .* exp(j*k*w*t));
ezplot(xx, [0 2]);
legend('Approx. with 5 terms');

% 11 
syms t
t0 = 0;
T = 2;
w = 2*pi/T;

x = heaviside(t) - heaviside(t-1);
ezplot(x, [0 2]);
legend('x(t)')

% Plotting coefficient magnitude and phase
figure
k = -5:5; % Using only 11 terms (-11 to 11)
a = (1/T) * int(x * exp(-j*k*w*t), t, t0, t0+T);
stem(k, abs(a));
legend('|a_k| , k=-11:11');

figure 
stem(k, angle(a));
legend('\angle a_k , k=-11:11');

% Approximation

figure
xx = sum(a .* exp(j*k*w*t));
ezplot(xx, [0 2]);
legend('Approx. with 11 terms');


%


