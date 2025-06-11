clc 
clear 
close all 

n=0:50; 
x1=0.9.^n; 
x2=0.8.^n; 
y=conv(x1,x2); 

subplot(121) 
stem(0:100,y) 
legend('Convolution'); 

syms n z 
x1=0.9.^n; 
x2=0.8.^n; 

X1=ztrans(x1,z); 
X2=ztrans(x2,z); 

Right=iztrans(X1*X2); 
n=0:100; 
Right=subs(Right,n); 

subplot(122) 
stem(0:100,Right) 
legend('Z^-^1[X_1(z)*X_2(z)]') 