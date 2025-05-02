clc
clear
close all

syms t w
x = simplify(exp(-t^2));
x1=fourier(x) %prefer
x2=(int(x*exp(-j*w*t),t,-inf,inf))