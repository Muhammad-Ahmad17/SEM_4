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
% ===============clc;
% clear;
% close all;
% fundamental period
% T = 2*pi/3;  %w=3
% two periods
% t=linspace(0,2*T,100);
% signal
% y=exp(3j*t);
% real
% real_y=real(y);
% img
% img_y=imag(y);
% 
% subplot(211);
% plot(t,real_y);
% 
% subplot(212);
% plot(t,img_y);
% j is img and pre-def
% ===============
% 
% % Define T based on Roll Number (Example: Roll Number = 20, then T = 10)
% Roll_Number = 20;
% T = Roll_Number / 2;
% % Define time range
% t = linspace(-T, T, 1000); % Covers a larger range to visualize the pulse
% % Define the rectangular pulse using unit step functions
% p_T = heaviside(t + T/2) - heaviside(t - T/2);
% % Plot the rectangular pulse
% figure;
% plot(t, p_T, 'b', 'LineWidth', 2);
% grid on;
% xlabel('Time (t)');
% ylabel('Amplitude');
% title(['Rectangular Pulse Function for T = ', num2str(T)]);
% ylim([-0.1, 1.1]); % Set y-axis limits for better visibility

%axis([-8 8 -0.1 1.2])
% ===============

    
% 	t=-5:0.01:5;
% 	
% 	x=heaviside(t)
% 	plot(t,x)
% 	axis([-8 8 -0.1 1.2])
% % 	
% 	
% 	t = -5:0.01:5;
% 	t0 = 2;
% 	x = heaviside(t - t0);
%     	plot(t,x)
% ===============
% t= 0:0.1:20;
% x=t.*exp(-0.1*t).*cos(t);
% % b  even = (x(t)+x(-t))/2
% x_e=0.5*(x+flip(x));
% % c  odd
% x_o=0.5*(x-flip(x));
% %even+odd
% x_eo=x_e+x_o;
% 
% 
% subplot(221)
% plot(t,x)
% title(' signal x(t)');
% 
% subplot(222)
% plot(t,x_e)
% title('even decomposition x even(t) of x(t)');
% 
% subplot(223)
% plot(t,x_o)
% title('odd decomposition x odd(t) of x(t)');
% 
% subplot(224)
% plot(t,x_eo)
% title('x even(t) + x odd(t)');

% ===============
% clc 
% clear
% close all
% 
% t1=0:.1:2;
% t2=2:.1:4;
% 
% x1=t1;
% x2=t2;


% flip > vector flip karta ha 
%- lagany say plot flip hota ha

% clc; clear; close all;
% 
% % Define original piecewise function x(t)
% t1 = 0:0.01:2;
% x1 = t1;
% t2 = 2:0.01:4;
% x2 = 4 - t2;
% 
% % Full x(t)
% t = [t1, t2];
% x = [x1, x2];
% 
% % Define transformations
% t_neg = -t;        % x(-t)
% t_scale = t / 2;   % x(t/2)
% t_shift_scale1 = (2 + 4*t);  % x(2 + 4t)
% t_shift_scale2 = (-2 - 4*t); % x(-2 - 4t)
% 
% % Plot original signal x(t)
% subplot(3,2,1);
% plot(t, x, 'b', 'LineWidth', 2);
% xlabel('t'); ylabel('x(t)');
% title('Original Signal x(t)');
% grid on;
% 
% % Plot x(-t) (Time reversal)
% subplot(3,2,2);
% plot(t_neg, x, 'r', 'LineWidth', 2);
% xlabel('t'); ylabel('x(-t)');
% title('Time-Reversed Signal x(-t)');
% grid on;
% 
% % Plot x(t/2) (Time scaling)
% subplot(3,2,3);
% plot(t_scale, x, 'g', 'LineWidth', 2);
% xlabel('t'); ylabel('x(t/2)');
% title('Time-Scaled Signal x(t/2)');
% grid on;
% 
% % Plot x(2 + 4t) (Time scaling and shifting)
% subplot(3,2,4);
% plot(t_shift_scale1, x, 'm', 'LineWidth', 2);
% xlabel('t'); ylabel('x(2 + 4t)');
% title('Scaled and Shifted Signal x(2 + 4t)');
% grid on;
% 
% % Plot x(-2 - 4t) (Time reversal, scaling, and shifting)
% subplot(3,2,5);
% plot(t_shift_scale2, x, 'c', 'LineWidth', 2);
% xlabel('t'); ylabel('x(-2 - 4t)');
% title('Transformed Signal x(-2 - 4t)');
% sgtitle('Signal Transformations');
% grid on;
% ===============
% t = 0:.1:2*pi
% x=sin(t);
% T=2*pi;
% %using command window
% for k=1:5
%     xk(k,:)=sin(t+k*T)
% end
% %using signal
% x_shifted = sin(t + T);
% figure;
% plot(t, x, 'b', 'LineWidth', 2);
% hold on;
% plot(t, x_shifted, 'r--', 'LineWidth', 2);
% 
% axis([0 2*pi -1 1]);
% ===============
% 
% clc;
% clear;
% close all;
% 
% t = 0:0.1:6*pi;
% x = cos(t) + sin(3*t)
% plot (t,x)
% ===============
subplot(311)
% Causal Signal (t >= 0)
t = 0:0.1:5;
x = t .* exp(-t);
plot(t, x)
title('Causal Signal')
xlabel('t')
ylabel('x(t)')
grid on

subplot(312)
% Anti-Causal Signal (t <= 0)
t = -5:0.1:0;
x = t .* exp(-t);
plot(t, x)
title('Anti-Causal Signal')
xlabel('t')
ylabel('x(t)')
grid on

subplot(313)
% Non-Causal Signal: x(t) = t*exp(-t) for t from -5 to 5
t = -5:0.1:5;
x = t .* exp(-t);
plot(t, x)
title('Non-Causal Signal')
xlabel('t')
ylabel('x(t)')
grid on
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
% ===============
% ===============
% ===============
% ===============

