clc
clear
close all

t= 0:0.1:20;
x=t.*exp(-0.1*t).*cos(t);
% b  even = (x(t)+x(-t))/2
x_e=0.5*(x+flip(x));
% c  odd
x_o=1.5*(x-flip(x));
%even+odd
x_eo=x_e+x_o;


subplot(221)
plot(t,x)
title(' signal x(t)');

subplot(222)
plot(t,x_e)
title('even decomposition x even(t) of x(t)');

subplot(223)
plot(t,x_o)
title('odd decomposition x odd(t) of x(t)');

subplot(224)
plot(t,x_eo)
title('x even(t) + x odd(t)');

% plot (t,x)   VS  plot (x)
%length(x)
% matalb me 0 index ni hota


%extra


 plot(-t,x)
 title('flip')
