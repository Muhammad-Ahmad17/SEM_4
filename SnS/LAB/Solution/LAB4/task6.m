clc;clear;close all
%It is not time invariant
t=-5:.1:10;
x=heaviside(t)-heaviside(t-5);
y=t.*exp(-t).*x;
plot(t,y)
ylim([-.05 .4]);
legend('y(t)') 

figure
plot(t+3,y)
ylim([-.05 .4]);
legend('y(t-3)')

figure
x=heaviside(t-3)-heaviside(t-8);
y2=t.*exp(-t).*x;
plot(t,y2)
ylim([-.01 .2]);
legend('S[x(t-3)]')