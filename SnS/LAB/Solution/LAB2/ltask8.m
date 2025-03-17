T = 2;
t = 0:0.1:T;

y_t = exp(1j * (pi * t + pi/3));

real_part = real(y_t);
imag_part = imag(y_t);
hold on;
plot(t, real_part, 'b', 'LineWidth', 2); 
plot(t, imag_part, 'r--', 'LineWidth', 2); 

xlabel('Time (t)');
ylabel('Amplitude');
title('Real and Imaginary Parts of y(t)');
legend('Real Part: cos(\pi t + \pi/3)', 'Imaginary Part: sin(\pi t + \pi/3)');
grid on;

hold off;  