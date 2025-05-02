clc
clear
close all

syms t w 

X =(1/(1+j*w));
x =  ifourier(X,t)
rewrite(x, 'heaviside')



%======================
syms t w n
X =1/(1+j*w);
x1 = (ifourier(X) )
% best approch ifourier(X,t) % imp
X =(1/(1+j*w));
x2 =  ifourier(X,t)
%-----
X =1/(1+j*w);
x3 =  ifourier(X,n)
