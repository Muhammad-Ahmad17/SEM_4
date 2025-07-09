clc;
clear;
close all;

nx = -2:2;   
nh = -1:3;  

x = nx.^2;   

h = 1 ./ (nh + (nh == 0)) + 2;  

y = conv(x, h);  
ny = (nx(1) + nh(1)):(nx(end) + nh(end));  

stem(ny, y, 'filled'); 
xlabel('n');
ylabel('y[n]');
title('Convolution of x[n] and h[n]');
grid on;
















Task6
n = -2:2 
x = n.^2 
n2 = -1:3; 
y = 1./n2+2; 
[y,n] = convm(x,n,y,n2)

clc; clear; close all;

n1 = -2:2;
x = n1.^2;

n2 = -1:3;
h = 1./n2 + 2;

[y, n] = convm(x, n1, h, n2);

delta = (n1 == 0);
[h_imp, n_h] = convm(delta, n1, h, n2);

[y_verify, n_verify] = convm(x, n1, h_imp, n_h);

subplot(3,1,1);
stem(n, y, 'r', 'filled'); 
title('System Response y(n)');
xlabel('n'); ylabel('y(n)');

subplot(3,1,2);
stem(n_h, h_imp, 'b', 'filled'); 
title('Impulse Response h(n)');
xlabel('n'); ylabel('h(n)');

subplot(3,1,3);
stem(n_verify, y_verify, 'g', 'filled'); 
title('Verification: x(n) * h(n)');
xlabel('n'); ylabel('y_{verified}(n)');
