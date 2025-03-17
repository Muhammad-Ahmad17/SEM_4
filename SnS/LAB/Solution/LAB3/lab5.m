clc;
clear;
close all;


n = -113:113;
u = (n >= 0);   % u[n] = 1 for n>=0, 0 for n<0


% Because n is symmetric, u[-n] is just flip(u)
u_neg = flip(u);

% Even part: (u[n] + u[-n]) / 2
u_even = (u + u_neg) / 2;

% Odd part: (u[n] - u[-n]) / 2
u_odd = (u - u_neg) / 2;

% Reconstruct u[n] by adding the even and odd parts
u_reconstructed = u_even + u_odd;

% Plot the original, even part, odd part, and reconstructed signals
figure;
subplot(4,1,1)
stem(n, u, 'filled')
title('Original Unit Step Signal u[n]')
xlabel('n'); ylabel('u[n]')
grid on

subplot(4,1,2)
stem(n, u_even, 'filled')
title('Even Part: (u[n] + u[-n])/2')
xlabel('n'); ylabel('u_{even}[n]')
grid on

subplot(4,1,3)
stem(n, u_odd, 'filled')
title('Odd Part: (u[n] - u[-n])/2')
xlabel('n'); ylabel('u_{odd}[n]')
grid on

subplot(4,1,4)
stem(n, u_reconstructed, 'filled')
title('Reconstructed u[n] (Even + Odd)')
xlabel('n'); ylabel('u[n]')
grid on
