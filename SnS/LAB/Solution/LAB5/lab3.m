clc
clear 
close all
% t1=-1:0.01:0.5;
% x1=.6*ones(size(t1));
%  t2=.5+0.01:0.01:3;
%  x2=.3*ones(size(t2));
%  t3=3.01:0.01:10;
%  x3=zeros(size(t3));
%  x=[x1 x2 x3];
%  t1= -1:.01: -.01;
%  t2=0:.01:10;
%  h1=zeros(size(t1));
%  h2=exp(- t2);
%  h=[h1 h2];
%  y=conv(x,h)*.01;
%  plot( -2:.01:20,y)
%  
 
 %==============
clc
clear
close all

t1 = [-1:0.01:0.5];
x1 = .6*ones(size(t1));
t2 = [.5+0.01:0.01:3];
x2 = .3*ones(size(t2));
t3 = [3.01:0.01:10];
x3 = zeros(size(t3));
x = [x1 x2 x3];
t1 = -1:.01:-.01;
t2 = 0:.01:10;
h1 = zeros(size(t1));
h2 = exp(-t2);
h = [h1 h2];
y = conv(x,h)*.01;
plot(-2:.01:20,y)
