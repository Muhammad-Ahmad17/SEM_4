% subplot (row,col,position on this plot)
clc
clear 
close all

x = linspace(0, 2*pi, 500);
y = x.^2 .* cos(x);
g = x .* cos(x);

figure
subplot(2,1,1);
plot(x, y, 'b-', 'LineWidth', 1.5); 
title('Subplot 1')

subplot(2,1,2);
plot(x, g, 'g--', 'LineWidth', 1.5);
title('Subplot 2')

