clc
clear
close all

subplot(311)
n = -1:3;
x = [0 1 2 3 4];
stem(n,x);%for discrite time
legend('x[n]')

%y(n)=x^2

subplot(312)
y_1 = x.^2;
stem(n,y_1);
legend('y_1[n]')

%?????
subplot(313)
a = 1/2;
y_2 = x.^a;
stem(n,y_2)
legend('y_2[n]')    


