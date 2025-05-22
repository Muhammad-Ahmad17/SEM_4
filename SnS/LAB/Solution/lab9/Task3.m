clc;clear;close all
syms t s
num = [1 5 4]
den = [1 0 0 0 1]
x = tf(num,den)
[r,p,k] = residue(num,den)
x1 = r(1)/(s-p(1))+r(2)/(s-p(2))+r(3)/(s-p(3))+r(4)/(s-p(4))+k


clc;clear;close all;
syms s t
X=(s^2+5*s+4)/(s^4+1)
x = ilaplace(X,t)
ezplot(x, [0 10])
title('Inverse of Rational Form')
grid on;            