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
t = 0:0.1:5;
x = t .* exp(-t);
disp(t)
clc;
clear;
close all;
% 
% % Define time vectors
% t_causal = 0:0.1:5;       % Time for causal signal
% t_anticausal = -5:0.1:0;  % Time for anti-causal signal
% t_noncausal = -5:0.1:5;   % Time for non-causal signal
% 
% % Compute signals
% x_causal = t_causal .* exp(-t_causal);
% x_anticausal = t_anticausal .* exp(t_anticausal);
% x_noncausal = t_noncausal .* exp(-abs(t_noncausal));
% 
% % Plotting
% figure;
% 
% subplot(3,1,1)
% plot(t_causal, x_causal, 'b', 'LineWidth', 1.5)
% title('Causal Signal')
% xlabel('t')
% ylabel('x(t)')
% grid on
% 
% subplot(3,1,2)
% plot(t_anticausal, x_anticausal, 'r', 'LineWidth', 1.5)
% title('Anti-Causal Signal')
% xlabel('t')
% ylabel('x(t)')
% grid on
% 
% subplot(3,1,3)
% plot(t_noncausal, x_noncausal, 'g', 'LineWidth', 1.5)
% title('Non-Causal Signal')
% xlabel('t')
% ylabel('x(t)')
% grid on
% 
% % ===============

% clc;
% clear;
% close all;
% 
% T = 2*pi; 
% t = linspace(0, 3*T, 1000); 
% x = cos(t) + sin(3*t);
% plot (t,x)

% ===============
% clc; clear; close all;
% 
% % Define time range
% t = -10:0.1:10;
% 
% % Define functions
% x_t = t.^2;  % x(t) = t^2
% y_t = t.^3;  % y(t) = t^3
% 
% % Compute x(-t) and y(-t)
% x_neg_t = (-t).^2;  % x(-t)
% y_neg_t = (-t).^3;  % y(-t)
% 
% % Check even or odd properties
% x_even = isequal(x_t, x_neg_t);   % If x(t) == x(-t), then it's even
% y_odd = isequal(y_t, -y_neg_t);   % If y(t) == -y(-t), then it's odd
% 
% % Display results
% if x_even
%     disp('x(t) = t^2 is an even function.');
% else
%     disp('x(t) = t^2 is not even.');
% end
% 
% if y_odd
%     disp('y(t) = t^3 is an odd function.');
% else
%     disp('y(t) = t^3 is not odd.');
% end
% 
% % Plot the functions
% figure;
% subplot(2,1,1);
% plot(t, x_t, 'b', t, x_neg_t, 'r--');
% title('x(t) = t^2 and x(-t)');
% legend('x(t)', 'x(-t)');
% grid on;
% 
% subplot(2,1,2);
% plot(t, y_t, 'g', t, -y_neg_t, 'm--');
% title('y(t) = t^3 and -y(-t)');
% legend('y(t)', '-y(-t)');
% grid on;
% % ===============
% clc;
% clear;
% close all;
% 
% 
% n = -113:113;
% u = (n >= 0);   % u[n] = 1 for n>=0, 0 for n<0
% 
% 
% % Because n is symmetric, u[-n] is just flip(u)
% u_neg = flip(u);
% 
% % Even part: (u[n] + u[-n]) / 2
% u_even = (u + u_neg) / 2;
% 
% % Odd part: (u[n] - u[-n]) / 2
% u_odd = (u - u_neg) / 2;
% 
% % Reconstruct u[n] by adding the even and odd parts
% u_reconstructed = u_even + u_odd;
% 
% % Plot the original, even part, odd part, and reconstructed signals
% figure;
% subplot(4,1,1)
% stem(n, u, 'filled')
% title('Original Unit Step Signal u[n]')
% xlabel('n'); ylabel('u[n]')
% grid on
% 
% subplot(4,1,2)
% stem(n, u_even, 'filled')
% title('Even Part: (u[n] + u[-n])/2')
% xlabel('n'); ylabel('u_{even}[n]')
% grid on
% 
% subplot(4,1,3)
% stem(n, u_odd, 'filled')
% title('Odd Part: (u[n] - u[-n])/2')
% xlabel('n'); ylabel('u_{odd}[n]')
% grid on
% 
% subplot(4,1,4)
% stem(n, u_reconstructed, 'filled')
% title('Reconstructed u[n] (Even + Odd)')
% xlabel('n'); ylabel('u[n]')
% grid on
% % ===============
% clc;
% clear;
% close all;
% 
% t = -1:0.1:3;
% 
% % Define the original signal x(t)
% x_t = t .* exp(-t);
% 
% % Define the time-reversed signal x(-t)
% x_neg_t = (-t) .* exp(t); % only 
% 
% % Plot both signals
% figure;
% subplot(211);
% plot(t, x_t, 'b', 'LineWidth', 2);
% xlabel('t'); ylabel('x(t)');
% title('Original Signal x(t)');
% grid on;
% 
% subplot(212);
% plot(t, x_neg_t, 'r', 'LineWidth', 2);
% xlabel('t'); ylabel('x(-t)');
% title('Time-Reversed Signal x(-t)');
% grid on;
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

