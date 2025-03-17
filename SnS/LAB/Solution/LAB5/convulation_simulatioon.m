close all
clear all
clc
% Initialization
t = -400:400; % Time range
X = zeros(1,length(t)); % Input signal
x1 = -150; x2 = 150; % Range of Input Signal
H = zeros(1,length(t)); % Impulse Response
h1 = -50; h2 = 50; % Range of Impulse Response Signal
Y = zeros(1,length(t)); xh1 = x1+h1; xh2 = x2+h2; % Convolution output

% Input Signal Generation
x = sin(pi*t/10)./(pi*t/10); x(t==0)=1; % Generate Input Sinc Signal
h = t./t; h(t==0)=1; % Generate Impulse Response
H(t>=h1&t<=h2) = h(t>=h1&t<=h2); % Fit the input signal within range
X(t>=x1&t<=x2) = x(t>=x1&t<=x2); % Fit the impulse response within range

% Plot Input Signal and Impulse Response
subplot(3,2,1)
plot(t,X,'b','LineWidth',3)
title('Input signal','FontWeight','b','FontSize',15)
grid on
subplot(3,2,2)
plot(t,H,'r','LineWidth',3)
title('Impulse Response','FontWeight','b','FontSize',15)
grid on

for n = xh1:xh2 % Convolution limits
    % Convolution steps
    f = fliplr(X);           % Flip
    Xm = circshift(f,[0,n]); % Shift
    m = Xm.*H;               % Multiply
    Y(t==n) = sum(m);  % Sum
   
    % Live Convolution Process
    subplot(3,2,[3 4])
    plot(t,H,'r',t,circshift(fliplr(X),[0,n]),'b','LineWidth',3)
    title('Convolution Process: 1. Flip, 2. Shift, 3. Multiply 4.Sum','FontWeight','b','FontSize',15)
    grid on;
    % Result of convolution live
    subplot(3,2,[5 6]);
    plot(t,Y,'k','LineWidth',3)
    axis tight
    grid on
    title('Convolution Output','FontWeight','b','FontSize',15)
    pause(0.01); % Pause between Update
    subplot(3,2,3)
    title('Illustration of 1D Convolution','FontWeight','b','FontSize',20)

    fig=gcf;
    fig.Units='normalized';
    fig.OuterPosition=[0 0 1 1]; %Open Current Figure in Maximized Mode
end