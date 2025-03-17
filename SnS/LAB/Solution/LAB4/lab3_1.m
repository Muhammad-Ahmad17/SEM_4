clc
clear
close all

t = -3:0.1:3;
x1 = heaviside(t) - heaviside(t-1);
x2 = heaviside(t) - heaviside(t-2);

a1 = 2;
a2 = 3;
z = a1*x1+a2*x2;

y = z.^2;
plot(t,y);
title('a')
xlabel('time');
ylabel('amplitude');

ylim([-1 26]);

figure
z1 = x1.^2;
z2 = x2.^2;
y =a1*z1+a2*z2;
plot(t,y);
title('b')
xlabel('time');
ylabel('amplitude');
ylim([-1 6]);
