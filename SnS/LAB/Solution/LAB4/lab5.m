clc;
clear;
close all;

% Define the time range
t = -5:.001:10;
% Define the input signal p(t) as a unit step difference (window function)
p = heaviside(t) - heaviside(t - 5);
% Compute the system response y(t) = t * exp(-t) * p(t)
y = t .* exp(-t) .* p;

figure;

% Plot the original output y(t)
subplot(3,1,1); % First subplot
plot(t, y, 'b', 'LineWidth', 1.5);
ylim([-.05 .4]);
grid on;
legend('y(t)');
title('Original System Output y(t)');
xlabel('Time t');
ylabel('Amplitude');

% --------------------- Testing Time Invariance ---------------------

% Shift the input signal by t0 = 3 (i.e., x(t-3))
t_shifted = t - 3;  % Shift time values
p_shifted = heaviside(t_shifted) - heaviside(t_shifted - 5); % Shifted input signal
y_shifted = t_shifted .* exp(-t_shifted) .* p_shifted; % Compute new output y(t-3)

% Plot the output of the system with shifted input
subplot(3,1,2); % Second subplot
plot(t, y_shifted, 'r', 'LineWidth', 1.5);
ylim([-.05 .4]);
grid on;
legend('y(t-3)');
title('Output when Input is Shifted by 3 (y(t-3))');
xlabel('Time t');
ylabel('Amplitude');

% ----------------- Comparing with Directly Shifted Output -----------------
% Directly shifting the function in the formula
p_direct = heaviside(t - 3) - heaviside(t - 8);
y_direct = (t - 3) .* exp(-(t - 3)) .* p_direct; % Also shifting y

% Plot directly computed y(t-3) 
subplot(3,1,3); % Third subplot
plot(t, y_direct, 'g', 'LineWidth', 1.5);
ylim([-.05 .4]);
grid on;
legend('y(t-3) Direct Computation');
title('Directly Computed Output y(t-3)');
xlabel('Time t');
ylabel('Amplitude');

% ----------------- Conclusion -----------------
% If y_shifted (computed from shifted input) matches y_direct (expected result),
% the system is time-invariant. If not, it is time-variant.


clc
clear
close all

t = -5:.001:10;
p = heaviside(t)-heaviside(t-5);
y = t.*exp(-t).*p;
plot(t,y)
ylim([-.05 .4]);
legend('y(t)')

figure
plot(t-3,y)
ylim([-.05 .4]);
legend('y(t3)')

figure
t = -5:.001:10;
p = heaviside(t-3)-heaviside(t-8);
y = t.*exp(-t).*p;
plot(t,y)
ylim([-.05 .4]);
legend('3[y(t)]')





