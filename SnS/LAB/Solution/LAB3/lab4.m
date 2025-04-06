x = -10:0.1:10;

y_even = x.^2;   % Even function example (y = x^2)
y_odd = x.^3;    % Odd function example (y = x^3)

y_even_neg = (-x).^2; % f(-x) for the even function
y_odd_neg = (-x).^3; % f(-x) for the odd function

% Plot the even function and its reflection
subplot(2, 1, 1);
plot(x, y_even, 'b');
hold on;
plot(-x, y_even_neg, 'r--');
grid on;

% Plot the odd function and its reflection
subplot(2, 1, 2);
plot(x, y_odd, 'b');
hold on;
plot(-x, y_odd_neg, 'r--');
grid on;
