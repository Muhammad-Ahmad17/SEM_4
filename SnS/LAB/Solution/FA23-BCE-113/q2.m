clc
clear
close all

syms t s 
R=3;  % 113 => 3

%x(t)
x = heaviside(t) - heaviside(t-R/4);
%h(t)
h = heaviside(t) - heaviside(t-R/2);

% t domain => s domain
X=laplace(x,s);
H=laplace(h,s);

% multiply both
A = X * H;

% taking inverse laplace 
ans=ilaplace(A,t) % conv of x and h 

ezplot(t,ans)
title('using laplace')
% A x B = laplace(A * B)
%(A * B)=ilaplace(A x B)

clc
clear
close all

t = -2:.1:4

R=3;  % 113 => 3

%x(t)
x = heaviside(t) - heaviside(t-R/4);
%h(t)
h = heaviside(t) - heaviside(t-R/2);

a=conv(x,h,'same') % for matching the sample set we use same 

plot(t,a)
title('using conv')

