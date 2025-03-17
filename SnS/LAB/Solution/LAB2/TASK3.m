clc;
clear;
close all;
R=8;
T=R/2;

t=-6:0.1:6
p=heaviside(t+T/2)-heaviside(t-T/2)
plot(t,p)
axis([-8 8 -0.1 1.2])