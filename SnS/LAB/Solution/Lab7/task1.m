clc
clear
close all
syms t w 
x = exp(-t^2) 
x1= fourier(x) 
x2=int(x*exp(-j*w*t),t,-inf,inf) 
