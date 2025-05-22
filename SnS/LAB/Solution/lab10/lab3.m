%a
clc
clear
close all
syms z n
x = n^2*heaviside(n);
X = ztrans(x,z)
%b
X2=iztrans(X,n);
rewrite(x,'heaviside')