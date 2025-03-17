t = -2*pi:0.01:2*pi;

x1 = cos(t);          
x2 = sin(t + pi/2);   

subplot(2,1,1);  % 2 rows, 1 column, 1st plot
plot(t, x1, 'b', 'LineWidth', 2);
xlabel('Time (t)');
ylabel('Amplitude');
title('Cosine Wave: cos(t)');
grid on;

subplot(2,1,2);  % 2 rows, 1 column, 2nd plot
plot(t, x2, 'r--', 'LineWidth', 2);
xlabel('Time (t)');
ylabel('Amplitude');
title('Shifted Sine Wave: sin(t + ?/2)');
grid on;
