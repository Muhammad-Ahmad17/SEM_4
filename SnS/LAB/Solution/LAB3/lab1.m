clc
clear 
close all
t = 0:.1:2*pi
x=sin(t);
T=2*pi;
%using command window
for k=1:10
    xk(k,:)=sin(t+k*T)
end
%using signal
x_shifted = sin(t + T);
figure;
plot(t, x, 'b', 'LineWidth', 2);
hold on;
plot(t, x_shifted, 'r--', 'LineWidth', 2);

axis([0 2*pi -1 1]);