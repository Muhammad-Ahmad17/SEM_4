clc; clear; close all;

% Define time range
t = -2:0.01:10;
t0 = 2;

% Define input signal x(t)
x = heaviside(t) - heaviside(t - 5);

% Compute original system output y(t)
y = t .* exp(-t) .* x;

% Shift input signal x(t - t0)
x_shifted = heaviside(t - t0) - heaviside(t - t0 - 5);

% Compute system output for shifted input y'(t)
y_shifted_input = t .* exp(-t) .* x_shifted;

% Compute time-shifted output y(t - t0)
y_time_shifted = (t - t0) .* exp(-(t - t0)) .* x_shifted;

% Plot results
figure;

subplot(3,1,1);
plot(t, y, 'b', 'LineWidth', 1.5);
title('Original Output y(t)');
xlabel('t'); ylabel('y(t)');
grid on;

subplot(3,1,2);
plot(t, y_shifted_input, 'r', 'LineWidth', 1.5);
title('Output of Shifted Input y''(t)');
xlabel('t'); ylabel('y''(t)');
grid on;

subplot(3,1,3);
plot(t, y_time_shifted, 'g', 'LineWidth', 1.5);
title('Time-Shifted Output y(t-t0)');
xlabel('t'); ylabel('y(t-t0)');
grid on;

% Check if y_shifted_input == y_time_shifted
if isequal(y_shifted_input, y_time_shifted)
    disp('The system is Time-Invariant.');
else
    disp('The system is Time-Variant.');
end
