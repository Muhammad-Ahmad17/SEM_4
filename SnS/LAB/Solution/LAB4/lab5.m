clc
clear
close all

t = -5:.001:10;
p = heaviside(t)-heaviside(t-5);
y = t.*exp(-t).*p;
plot(t,y)
ylim([-.05 .4]);
legend('y(t)')

figure
plot(t+3,y)
ylim([-.05 .4]);
legend('y(t3)')

figure
t = -5:.001:10;
p = heaviside(t-3)-heaviside(t-8);
y = t.*exp(-t).*p;
plot(t,y)
ylim([-.05 .4]);
legend('y(t)')