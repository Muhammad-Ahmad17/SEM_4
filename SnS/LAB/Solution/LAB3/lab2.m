clc;
clear;
close all;

T = 2*pi; 
t = linspace(0, 3*T, 1000); 
x = cos(t) + sin(3*t);
plot (t,x)



