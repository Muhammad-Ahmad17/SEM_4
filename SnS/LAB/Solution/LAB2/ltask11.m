clc
clear 
close all
%y = gauspulse(t)
%plot(t,y)
%help dirac
    
t=-3:0.1:3
y= inf==dirac(t)
plot(t,y)
xlabel('Time')
ylabel('Amplitude')
title('Unit impulse using dirac(t)')
