clc;
clear;
close all;
t=0:0.1:2*pi/3;
y=exp(3*j*t);
plot(t,y)
xlabel('Time Axis') 
ylabel('Amplitude') 
title('Graph of f(n)') 
% j is img and pre-def