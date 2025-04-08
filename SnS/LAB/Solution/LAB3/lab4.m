clc
clear 
close all


x = -10:0.1:10;

y_even = x.^2;   
y_odd = x.^3;  

plot(x,y_even)
figure
plot(x,flip(y_even))

plot(x,y_odd)
figure
plot(x,-flip(y_odd)) % - for amplitude and flip for time
