%Convolution in time domain 
%Lab 9, In Lab 
clc;clear;close all 
syms t s 
x=5*exp(-t)*heaviside(t) 
h=t*exp(-t)*heaviside(t) 
X=laplace(x,s); 
H=laplace(h,s); 
R=ilaplace(X*H,t); 
ezplot(R,[0 16]); 
ylim([-0.1 1.5]) 
title('Time domain convolution using Laplace transform property') 
figure 
t=0:0.01:8 
x=5.*exp(-t).*heaviside(t) 
h=t.*exp(-t).*heaviside(t) 
y=conv(x,h); 
plot(0:.01:16,y); 
title(' Time domain convolution using conv command ') 
ylim([-0.1 150])