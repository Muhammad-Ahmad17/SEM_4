clc
clear
close all
f = [-3,5,6,7,8];
n=-2:2;
stem(n,f)

syms z n
F = sum(f*(z.^-n))
pretty (F)