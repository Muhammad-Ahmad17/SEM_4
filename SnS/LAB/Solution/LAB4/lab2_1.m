
clc
clear
close all

n = -1:3;
x = [0 1 2 3 4];
stem(n,x);
%a part (at a time  single hi run ho ga )
% hold on;
% 
% y = x.^2;
% stem(n,y);


% dynamic ha b awala 
hold on ;
a = 1/2;
y = upsample(x,1/a)
stem(-2:7,y)
legend('x[n]','y_2[n]')


