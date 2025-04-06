clc;
clear;
close all;

% Define time vector
t = -5:0.001:10;
t0 = 2;  % Time shift

% Define original input signal: p(t) = u(t) - u(t - 5)
p = heaviside(t) - heaviside(t - 5);

% System: y(t) = t * exp(-t) * p(t)
y = t .* exp(-t) .* p;

% Shifted input: p(t - t0)
p_shifted = heaviside(t - t0) - heaviside(t - t0 - 5);

% Output for shifted input: y1(t) = t * exp(-t) * p(t - t0)
y1 = t .* exp(-t) .* p_shifted;

% Time-shifted original output: y2(t) = y(t - t0)
% Since t - t0 may be out of range, we interpolate
y2 = interp1(t, y, t - t0, 'linear', 0);  % Linear interpolation with 0 padding

% Plot comparison
figure;

subplot(3,1,1);
plot(t, y1, 'r', 'LineWidth', 1.2);
title('y1(t) = S[x(t - t0)]');
xlabel('t'); grid on;

subplot(3,1,2);
plot(t, y2, 'b', 'LineWidth', 1.2);
title('y2(t) = y(t - t0)');
xlabel('t'); grid on;

subplot(3,1,3);
plot(t, y1 - y2, 'k', 'LineWidth', 1.2);
title('Difference: y1(t) - y2(t)');
xlabel('t'); grid on;

% Decision
if max(abs(y1 - y2)) < 1e-5
    disp('? System is Time Invariant');
else
    disp('? System is NOT Time Invariant');
end

% ----------------- Conclusion -----------------
% If y_shifted (computed from shifted input) matches y_direct (expected result),
% the system is time-invariant. If not, it is time-variant.




