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


