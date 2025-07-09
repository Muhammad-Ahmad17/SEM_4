clc
clear
close all

%a.
syms t w
x = t*exp(-3*t)* heaviside(t); % * by heaviside(t) to make it is causal
X = fourier(x,w);
% w is over write with non syms 
w = -20:.1:20;
X = subs(X,w);
% substitute syms type w into nonsyms type
subplot(4,1,1)
plot(w,abs(X));
legend('magnitude')


subplot(4,1,2)
%b
plot(w,angle(X));
legend('angle')


subplot(4,1,3)
%c
plot(w,real(X))
legend('real')


subplot(4,1,4)
%d
plot(w,imag(X))
legend('imaginary')


