clc;
clear;
close all;

nx = -2:2;   
nh = -1:3;  

x = nx.^2;   

h = 1 ./ (nh + (nh == 0)) + 2;  

y = conv(x, h);  
ny = (nx(1) + nh(1)):(nx(end) + nh(end));  

stem(ny, y, 'filled'); 
xlabel('n');
ylabel('y[n]');
title('Convolution of x[n] and h[n]');
grid on;


