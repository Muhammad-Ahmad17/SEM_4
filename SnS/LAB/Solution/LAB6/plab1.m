clc 
clear
close all

t = 0 :.1:6;
x= t.*exp(-t);
xp=repmat(x,1,4);  % repete matrix ( x , 1 row , 4 column)
tp= linspace(0,24 , length(xp)); % why (-6 , 18)
plot(tp,xp);    

legend('x(t) in 4 time period');

% 
figure %  trignometry

t0=0;
T=6;
w=2*pi/T;

% for integration derivation we use symbolic variables
syms t 

x= t.*exp(-t);

k=-40:40;

% analysis equation
a = (1/T)*int(x*exp(-j*k*w*t),t,t0,t0+T);
xx=sum(a.*exp(j*k*w*t));

ezplot(xx,[-6,18]);
legend ('approximate signal in 4 periods using a_k');