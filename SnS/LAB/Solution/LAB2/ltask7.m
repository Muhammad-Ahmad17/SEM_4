A = 113;

B1 = A / 100;
B2 = -A / 100;
T = A / 2;

% Define time range
t = -T:0.1:T; 

% Compute signals
x_t = A * exp(B1 * t);%dont do x(t)cuz we are directly using this in exp
y_t = A * exp(B2 * t);

% Plot signals using subplot
figure;

hold on
plot(t, x_t, 'bo', 'LineWidth', 2);
hold on
xlabel('Time (t)');
ylabel('Amplitude');

title('exponentional sigmal');
grid on;
plot(t, y_t, 'ro', 'LineWidth', 2);
legend('Growth Exponential', 'Decaying Exponential');

hold off
axis([-20 20 0 4000])




%===================


