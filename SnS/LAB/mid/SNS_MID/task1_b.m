clc;
clear;
close all;

R=3

% a : t^R

t=-2:.1:2                        %interval
x_t= t.^6                        %x(t)=t^2R
x_neg_t = flip(x_t)          %x(-t)
neg_x_neg_t=flip(-x_t)   %-x(-t)

% if (x(t)=x(-t)) 
%   even
% else if (x(t)=-x(-t))
%   odd
% else
%   not even and odd

% SO OUR PART 2 IS EVEN


% orignal signal x(t)
subplot(311)
plot(t,x_t);
title('x(t)');

%invert on time axis x(-t)
subplot(312)
plot(t,flip(x_t))
title('x(-t)');

%invert on time axis and amp.axis -x(-t)
subplot(313)
plot(t,flip(-x_t))
title('-x(-t)');






