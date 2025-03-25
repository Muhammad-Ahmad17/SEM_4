clc
clear
close all

t1=0:.1:4;
t2=0:-.1:-4;

%even
x1=t1.^2;
x2=t2.^2;

%odd
x3=t1.^5;
x4=t2.^5;

subplot(221)
plot (t1,x1)
title('x^2');

subplot(222)
plot (t2,x2)
title('-x^2');

subplot(223)
plot (t1,x3)
title('x^5');

subplot(224)
plot (t2,x4)
title('-x^5');



clc; clear; close all;

% Define time range
t = -10:0.1:10;

% Define functions
x_t = t.^2;  % x(t) = t^2
y_t = t.^3;  % y(t) = t^3

% Compute x(-t) and y(-t)
x_neg_t = (-t).^2;  % x(-t)
y_neg_t = (-t).^3;  % y(-t)

% Check even or odd properties
x_even = isequal(x_t, x_neg_t);   % If x(t) == x(-t), then it's even
y_odd = isequal(y_t, -y_neg_t);   % If y(t) == -y(-t), then it's odd

% Display results
if x_even
    disp('x(t) = t^2 is an even function.');
else
    disp('x(t) = t^2 is not even.');
end

if y_odd
    disp('y(t) = t^3 is an odd function.');
else
    disp('y(t) = t^3 is not odd.');
end

% Plot the functions
figure;
subplot(2,1,1);
plot(t, x_t, 'b', t, x_neg_t, 'r--');
title('x(t) = t^2 and x(-t)');
legend('x(t)', 'x(-t)');
grid on;

subplot(2,1,2);
plot(t, y_t, 'g', t, -y_neg_t, 'm--');
title('y(t) = t^3 and -y(-t)');
legend('y(t)', '-y(-t)');
grid on;
