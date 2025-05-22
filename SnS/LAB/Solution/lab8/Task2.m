clc; clear; close all;
syms s t
Y = 1/s + 2/(s+4) + 1/(s+5) 
y = ilaplace(Y, t)         


