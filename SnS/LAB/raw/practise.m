clc 
clear 
close all 
% x  = -2 :.1: 2 ;
% y=x.^2;
% plot(x,y)
% 

% z=0 :2.5: 10 ;
% disp(z)
% v = linspace(0, 10, 5); % Generates 5 points from 0 to 10
% disp (v)
% %==============================
% x = linspace(0,2*pi,100)
% disp (x)
% 
% y1  =(x.^2).*(cos(x));
% y2  = x.*cos(x);
% y3= (2.^x).*sin(x); 
% % overall different graphs 
% plot (x,y1)
% figure
% plot (x,y2)
% figure
% plot (x,y3)
% % in single graph
% figure
% plot (x,y1,x,y2,x,y3);
% % -=========================

% 
% x= linspace(0,2*pi,100);
% plot(x,cos(x),'b*',x,sin(x),'r.');
% xlabel('time');
% ylabel('amplitude');
% title('sin and cos function');
% legend('cos','sin')
% % =====================

% SUBPLOT 
% x = linspace(0,2*pi,100);
% y1  =(x.^2).*(cos(x));
% y2  = x.*cos(x);
% y3= (2.^x).*sin(x); 
% subplot(311)
% plot (x,y1)
% subplot(312)
% plot (x,y2)
% subplot(313)
% plot (x,y3)
% ===============
% 
% x = linspace(0, 2*pi, 100);
% y1 = cos(x);
% y2 = sin(x);
% 
% plot(x, y1, 'b'); % Plot y1 in blue
% hold on; % Keep the current plot
% plot(x, y2, 'r'); % Overlay y2 in red
% hold off; % Stop holding, new plots will replace this figure
% ===============


% n= -2 : .1:  2;
% o = n.^2;
% stem (n,o)
% ===============
% 
% t1=-2:.01:2;
% t2=2.1:.01:4.9;
% t3=5:.01:8;
% 
% f1 = ones(size(t1)); 
% f2 = zeros(size(t2));
% f3 = t3 .* sin(4 * pi * t3);
% t=[t1 t2 t3]; 
% f=[f1 f2 f3];
% plot(t,f) 

% ===============
% t=linspace(-5,5,100);
% y=cos(pi.*t);
% plot(t,y)
% ===============
% t=-5:.1:5	
% x=cos(pi*t)
% plot(t,x)
% ===============

% ===============
% ===============
% ===============
% ===============
% ===============
% ===============
% ===============
% ===============
% ===============
% ===============

