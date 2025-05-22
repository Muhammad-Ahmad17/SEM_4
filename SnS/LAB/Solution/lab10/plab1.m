clc 
clear 
close all

syms n z
u = heaviside(n);               
x = u + n*u + n^2*u;  

X = ztrans(x, n, z)           

