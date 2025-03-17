%1
t1=-113:0.1:113
x1=cos(t1)

%2
n1=-113:0.1:113
x2=cos(n1)

% Plot both on the same figure
figure;
plot(t1, x1, 'b-', 'LineWidth', 1.5); % Blue solid line for linspace
hold on;
stem(n1, x2, 'ro', 'MarkerSize', 4);  % Red circles for colon operator points
hold off;
axis([-10 10 -1 1])

% Labels and title
xlabel('Time');
ylabel('Amplitude');
title('Comparison of CT vs DT');
grid on;