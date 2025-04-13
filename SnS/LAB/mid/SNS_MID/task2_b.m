clc
clear
close all

R=3

n =-1:3       % interval
x=[0 , R , 2*R , 3*R , 4*R]    %x[n]

y_n = upsample(x , 2)   %x^2[n]

% static system because define on its orignal interval after appling
% operation

subplot(211)
stem(n,x); % actual 
title('x[n]')
subplot(212)
stem(-6:3,y_n) % shifted
title('x^[n/2]')









