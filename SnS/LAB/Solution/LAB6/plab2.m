clc
clear
close all

syms t
t0 = 0;
T =2;
w = 2*pi/T;
x = heaviside(t) - heaviside(t-1)
ezplot(x,[0 2]);
legend('x(t)')

% ploting coffecent phase and magnitude
figure
k = -20:20;
a = (1/T)*int(x*exp(-j*k*w*t),t,t0,t0+T);
stem(k,abs(a));
legend('|a_k| , k=-20:20');


figure 
stem(k,angle(a));
legend('\angle a_k , k=-20:20');

% approximation

figure
xx=sum(a.*exp(j*k*w*t));
ezplot(xx,[0 2]);
legend('Approx. with 41 time')