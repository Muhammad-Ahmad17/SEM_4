clc
clear
close all

subplot(311)
n = -1:3;
x = [0 1 2 3 4];
stem(n,x);%for discrite time


legend('x[n]')

subplot(312)
y = x.^2;
stem(n,y);
legend('y_1[n]')

subplot(313)
a = 1/2;
y = upsample(x,1/a)
stem(-2:7,y)
legend('y_2[n]')

