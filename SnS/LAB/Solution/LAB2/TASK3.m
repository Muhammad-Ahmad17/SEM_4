clc;
clear;
close all;
R=8;
T=R/2;

t=-6:0.1:6
p=heaviside(t+T/2)-heaviside(t-T/2)
plot(t,p)
axis([-8 8 -0.1 1.2])




% unfiltered
clc
clear
close all

roll_no = 113;
T = roll_no / 2;
t = linspace(-T/2,T/2,1000);
%t = -T/2 :.1 : T/2 ;
p = heaviside (t + T / 2) - heaviside (t - T / 2);

plot ( t , p );
axis([-8 8 -0.1 1.2])
