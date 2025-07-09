clc;
clear;
close all;

% Define symbolic variables
syms t T

% Define the signal x(t) = 2cos(pi*t)
x = 2 * cos(pi * t);

% Energy Calculation: Integrate the square of the signal over one period [0, 2]
energy_integral = int(x^2, t, 0, 2);  % One period of cos(pi*t) is from t = 0 to t = 2
Ex = energy_integral;  % Energy is the result of this integral

% Power Calculation: Average energy over the period (Period = 2)
Px = Ex / 2;  % Power is the energy divided by the period (T=2)

% Display the results
disp('Energy (Ex):');
disp(Ex);  % Display energy

disp('Power (Px):');
disp(Px);  % Display power

% Define the time vector for plotting
t_vals = 0:0.01:2;  % One period, from t=0 to t=2
x_vals = double(subs(x, t, t_vals));  % Substitute symbolic expression into the time vector


 
