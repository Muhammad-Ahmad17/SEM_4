
clc
clear
close all

n = -1:3;
x = [0 1 2 3 4];
stem(n,x);
% %a part (at a time  single hi run ho ga )
% hold on;
% 
% y = x.^2;
% stem(n,y);


% dynamic ha b awala 
figure
a = 1/2;
x1 = upsample(x,1/a)
n1=-2:7;
disp(n1) % we have to match the sample element means 10 in both
disp(x1)  % so we explicitly gives -2:7 (10 factors).

stem(-2:7,x1)
legend('x[n]','y_2[n]')


