clc
clear
close all

syms t w
x = sin(pi*t)/(pi*t);
X = fourier(x,w);
ezplot(X, [-10 10]) % -10 -- 10 ==> time domain
% ezplot use for sym ploting
legend('X(\Omega)');
xlabel('\Omega');
title('Fourier response of sin(t)');