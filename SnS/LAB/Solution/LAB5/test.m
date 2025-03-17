function [y,n] = test(x,n1,h,n2)
a = n1(1) + n2(1);
b = n1(end) + n2(end);
n  = a:b;
N = length(n);
y = zeros(1,N);
for i = 1:length(x)
for j = 1:length(h)
    
y(i+j-1) = y(i+j-1) + x(i) * h(j);
end
end
stem(n,y);

end