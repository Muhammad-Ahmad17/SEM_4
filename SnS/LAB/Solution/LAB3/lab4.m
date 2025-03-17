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
