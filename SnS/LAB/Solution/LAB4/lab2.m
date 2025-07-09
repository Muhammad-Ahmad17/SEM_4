clc
clear
close all

n = -1:3;
x = [0 1 2 3 4];
subplot(311)

stem(n,x);%for discrite time
legend('x[n]')

%y(n)=x^2

subplot(312)
y_1 = x.^2;
stem(n,y_1);
legend('y_1[n]')

 


