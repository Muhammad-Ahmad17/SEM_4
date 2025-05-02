clc
clear
close all

syms t w
x = exp(-t)*heaviside(t);
X = fourier(x,w)

% answer is same as question of above