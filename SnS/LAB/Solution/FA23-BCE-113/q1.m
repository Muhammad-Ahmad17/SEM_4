clc
clear
close all

R=3;  % 113 => 3
t=-10:.1:10;

x=heaviside(t)-heaviside(t-R);

% y1 seems to be dynamic because the y axis is changing at every instance
% of time
y1=R*x;
% y2 seems to be dynamic because the y axis is changing at every instance
% of time
y2=t-R;

subplot(3,1,1)
plot(t,y1)
title('y1(t)')
subplot(3,1,2)
plot(t,y2)
title('y2(t)')
subplot(3,1,3)
plot(t,x)
title('x(t)')

