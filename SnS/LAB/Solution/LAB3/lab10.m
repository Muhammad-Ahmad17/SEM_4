clc
clear
close all

t=-1:.01:3;
x_t = t .* exp(-t);
x1_t = (t - 2) .* exp(-(t - 2));
x2_t = (t + 3) .* exp(-(t + 3));

subplot(311)
plot(t,x_t,'g');
title('orignal');
xlabel('t');
ylabel('x_t');
grid on;

subplot(312)
plot(t,x1_t,'b-');
title('shifted version of x_t by two units to the right');
xlabel('t');
ylabel('x1_t');
grid on;

subplot(313)
plot(t,x2_t,'r--');
title('shifted version of x_t by three units to the left');
xlabel('t');
ylabel('x2_t');
grid on;



