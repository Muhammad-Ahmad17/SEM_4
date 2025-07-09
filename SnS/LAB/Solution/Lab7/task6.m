clc
clear
close all


syms t w
x1 = heaviside(t)-heaviside(t-2);
x2 = heaviside(t)-heaviside(t-4);
X1 = fourier(x1,w);
X2 = fourier(x2,w);
right = ifourier(rewrite(X1*X2,'exp'),t);

subplot(2,1,1)
ezplot(right,[0 8]);
title('with fourier transform')


t1 = 0:.01:2;
t2 = 2.01:.01:4;
x1 = [ones(size(t1)) zeros(size(t2))];
x2 = ones(size([t1 t2]));
y = conv(x1,x2)*.01;

subplot(2,1,2)
plot(0:.01:8,y);

title('with conv')	