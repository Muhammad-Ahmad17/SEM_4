clc;
clear;
close all;

t=-5:0.01:5;

x=heaviside(t)
plot(t,x)
axis([-8 8 -0.1 1.2])


t = -5:0.01:5;
t0 = 2;
x = heaviside(t - t0);
