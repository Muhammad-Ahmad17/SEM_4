close all
x = -2:0.1:2; % -left_extreme : step(if any) : right_extreme
y = x.^2; 

plot(x, y, 'b', 'LineWidth', 2);  
xlabel('x');  
ylabel('y = x^2');  
title('Plot of y = x^2 for ?2 ? x ? 2');  

grid on;  