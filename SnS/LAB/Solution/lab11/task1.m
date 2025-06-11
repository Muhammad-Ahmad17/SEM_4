clc
clear 
close all


syms n z 
x1=n^2; 
x2=2^n; 
a1=3; 
a2=4;

Le=a1*x1+a2*x2; 
 
Left=ztrans(Le,z) 

 X1=ztrans(x1,z); 
X2=ztrans(x2,z); 
Right=a1*X1+a2*X2




syms n z 
m=2; 
x1=3^(n-m)*heaviside(n-m); 
Left=simplify(ztrans(x1,z)) 
 
x=3^n*heaviside(n); 
X=ztrans(x,z); 
Right=simplify((z^(-m))*X)