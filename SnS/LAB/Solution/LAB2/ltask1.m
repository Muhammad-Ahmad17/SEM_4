clc;
clear;
close all;
%ROLL IS 113
t=-113:0.01:113
x=cos(t)
plot(t,x)
axis([-10 10 -1 1])
title(' continuous  time  signal x=cos(t)')
xlabel('time')
ylabel('amplitude')