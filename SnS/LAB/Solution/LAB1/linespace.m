clc;
clear;
close all;
%====================================%
% Define x using linspace
x1 = linspace(0, 2*pi, 100);
y1 = sin(x1);

% Define x using colon operator
x2 = 0:pi/50:2*pi;
y2 = sin(x2);

% Plot both on the same figure
figure;
plot(x1, y1, 'b-', 'LineWidth', 1.5); % Blue solid line for linspace
hold on;
plot(x2, y2, 'ro', 'MarkerSize', 4);  % Red circles for colon operator points
hold off;

% Labels and title
xlabel('x');
ylabel('sin(x)');
title('Comparison of linspace vs Colon Operator');
legend('linspace(0,2\pi,100)', '0:\pi/50:2\pi', 'Location', 'best');
grid on;
%====================================%


%====================================%
% full descriptive 
clc;
clear;
close all;
x = linspace(0, 2*pi, 500);
y = x.^2 .* cos(x);
g = x .* cos(x);
f = 2.^x .* sin(x);
% Plot the functions
plot(x, y, 'b-', 'LineWidth', 1.5); 
hold on;
plot(x, g, 'g--', 'LineWidth', 1.5); 
plot(x, f, 'r-.', 'LineWidth', 1.5); 

% Labels and title
xlabel('x');
ylabel('Function values');
title('Plot of y(x), g(x), and f(x) in the same figure');
legend('y(x) = x^2 cos(x)', 'g(x) = x cos(x)', 'f(x) = 2^x sin(x)', 'Location', 'Best');
grid on;
hold off;

