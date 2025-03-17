clc 
clear 
close all

nx=0:4;
x = ones (size(nx));
nh= -5:5;
h=nh;
y=conv(x,h);
stem(-5:9,y)
axis([-10 40 -16 -16])
legend('y[n]')
grid on