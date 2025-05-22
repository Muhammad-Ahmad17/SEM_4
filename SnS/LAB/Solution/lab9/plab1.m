%Convolution in the complex frequency domain 
%Lab 9, Pre Lab 
clc;clear;close all 
syms t s 
X1=1/(s+1)^2; 
X2=2/(s+1)^3; 
x1=ilaplace(X1,t); 
x2=ilaplace(X2,t); 
con=(2*pi*j)*laplace(x1*x2) 