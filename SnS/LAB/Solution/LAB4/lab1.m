clc
close all
clear

t=-5:.01:5;
x=heaviside(t)-heaviside(t-1);

y_1 = 3 * x;   % static cuzx(t)is same 
y_2 = heaviside(t-1)-heaviside(t-1-1); % dynamic shift x(t) by 1 unit

subplot(311)
plot (t,x)
subplot(312)
plot (t,y_1)
subplot(313)
plot (t,y_2)