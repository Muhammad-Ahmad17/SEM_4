% Program to understand the use of script file 

t=-5:0.1:5; 
f=t.*cos(2*pi*t); 
plot(t,f) 

%{
----------------------------------------------------------
| Feature         | Functions                      | Scripts                      |
----------------------------------------------------------
| Input/Output   | Accept input & return output   | No direct input/output       |
----------------------------------------------------------
| Workspace      | Separate (local variables)     | Base workspace (global vars) |
----------------------------------------------------------
| File Name      | Must match function name       | Can have any name            |
----------------------------------------------------------
| Reusability    | Reusable with different inputs | Runs sequentially once       |
----------------------------------------------------------
| Use Case       | Modular, reusable code         | Quick execution, setup       |
----------------------------------------------------------
%}


clc;
clear;
close all

t = 0:0.01:10;      % Define time vector
T = 1;              % Trial period

for k = 1:10
    xk(k, :) = sin(t + k * T);   % Time-shifted versions of sin(t)
end

% Plot all versions on a single figure
figure;
hold on;
for k = 1:10
    plot(t, xk(k, :));
end
hold off;
title('Visual Check for Periodicity');
xlabel('Time');
ylabel('Amplitude');


