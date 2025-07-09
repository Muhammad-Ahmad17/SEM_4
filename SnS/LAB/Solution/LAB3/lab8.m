clc;
clear;
close all;

t = -1:0.1:3;
%  x(t)
x_t = t .* exp(-t);
%  x(-t)
x_neg_t = (-t) .* exp(t);
% Plot both signals
figure;
subplot(211);
plot(t, x_t);
title('Original Signal x(t)');
subplot(212);
plot(t, x_neg_t);
title('Time-Reversed Signal x(-t)');

