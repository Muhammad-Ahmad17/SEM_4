clc;
clear;
close all;

% power function :
% energy = infinite 
% power = finite

% energy function :
% power = infinite 
% energy = finite(less than infinite)

%a
syms t T 
x = heaviside(t);
d = int(abs(x)^2,t,-T,T)
Ex = limit(d,T,inf)
Px = limit( (1/(2*T))*d,T,inf)

% b
clc;
clear;
close all;

syms t T
%system is 
x = heaviside(t)-heaviside(t-1);

d = simplify(int(x)^2,t,-T,T)

%d = double( int(abs(x).^2,t,-inf,inf) ) % integrate((abs(x)t^2),t,limit1,limit2)
Px =( limit( (1/(2*T))*d,T,inf))
Ex = (limit(1.*d,T,inf)  )


% symbs to double or simplify 











t = -5:0.01:5;  

x1=heaviside(t);
x2=heaviside(t)-heaviside(t-1);

subplot(211)
plot(t,x1);
title('u(t)');
%ylim([-0.2, 1.2]);
subplot(212)
plot (t,x2)
title('u(t)-u(t-1)');
%ylim([-0.2, 1.2]);

