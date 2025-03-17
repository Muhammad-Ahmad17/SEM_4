clc
clear
close all

n = 0:5;
x1 = 0.8.^n;
x2 = cos(n);
a1 = 2;
a2 = 3;

z = a1*x1+a2*x2;
y1 = 2.^z
stem(n,z)

figure
z1 = 2.^x1;
z2 = 2.^x2;

y2 = a1*z1+a2*z2

stem (n,y2)