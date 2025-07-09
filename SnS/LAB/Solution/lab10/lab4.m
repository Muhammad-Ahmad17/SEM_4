clc
clear
close all

num = [ 2 3];
den = [ 1 5 6];
[R,P,K] = residue(num,den);

%a. s
syms n z
X = (2*z+3)/(z^2+5*z+6);
using_rational=iztrans(X,n)

%b
X = 3/(z+3)-1/(z+2);
partial_form=iztrans(X,n)
