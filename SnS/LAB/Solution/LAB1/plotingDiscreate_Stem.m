figure
n = -3:0.1:3;
% or 
n = linspace(-3, 3, 50);
f= n.^2 ;
stem(n,f) ;
xlabel('Time Axis') 
ylabel('Amplitude') 
title('Graph of f(n)') 