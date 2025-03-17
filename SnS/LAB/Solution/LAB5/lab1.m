% clc;clear;close all
%  tx1 =  -2:.1:0;
%  tx2 = 0:.1:2;
%  tx3 = 2:.1:4;
%  tx = [tx1 tx2 tx3];
%  x1 = zeros(size(tx1));
%  x2 = ones(size(tx2));
%  x3 = zeros(size(tx3));
%   x = [x1 x2 x3];
%   
%  th1 =  -2:.1:0;
%  th2 = 0:.1:1;
%  th3 = 1:.1:4;
%  th = [th1 th2 th3];
%  h1 = zeros(size(th1));
%  h2 = 1 - th2;
%  h3 = zeros(size(th3));
%  h = [h1 h2 h3];
%  plot(tx,x,th,h,':')
%  ylim([ -.1 1.1])
%  legend('x(\tau)','h(\tau)')
%  
%  plot(tx,x, th,h, ':*')
%  legend('x(\tau)', 'h( \tau)')
%  ylim([ -.1 1.1])


% task1
clc
clear 
close all


 step=0.1;
 t=0:step:2;
 x=ones(size(t));
 t1=0:step:1;
 t2=1+step:step:2;
 h1=1-t1;
 h2=zeros(size(t2));
 h=[h1 h2];
 y=conv(x,h)*step;
 ty=0:step:4;
  plot(ty,y);
  
  
  % task2
  figure
   hh=deconv(y,x)*(1/step);
   plot(t,hh)
 ylim([- .1 1.1]);
 legend('impulse response h(t)')