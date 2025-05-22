clc; clear; close all;
syms t s
f = -1.25+3.5*t*exp(-2*t)+1.25*exp(-2*t)
F = laplace(f,s)
