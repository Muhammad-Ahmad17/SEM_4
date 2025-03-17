clc;
clear;
close all;
%ROLL IS 113
n=-113:0.1:113
x=cos(n)
stem(n,x)
axis([-10 10 -1 1])
title(' continuous  time  signal x=cos(t)')
xlabel('time')
ylabel('amplitude')