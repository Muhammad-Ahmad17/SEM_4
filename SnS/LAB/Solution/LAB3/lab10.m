clc
clear
close all

t=-1:.01:3;
x_t = t .* exp(-t);
x1_t = (t - 2) .* exp(-(t - 2)); % put t = t-2
x2_t = (t + 3) .* exp(-(t + 3)); % put t = t+3

subplot(311)
plot(t,x_t);

subplot(312)
plot(t,x1_t,);

subplot(313)
plot(t,x2_t);






Task7	
t = -10:0.01:10;
x = cos(2 * pi * t);

% S1: 
y1 = x.^2; 
% S2: 
y2 = t .* x

figure;
subplot(3,1,1); plot(t, x);
subplot(3,1,2); plot(t, y1);
subplot(3,1,3); plot(t, y2);
% Conclusion: 
% System 1 is nonlinear — violates superposition principle due to nonlinearity of squaring.
% System 2 is linear — satisfies superposition and homogeneity, hence linear.
