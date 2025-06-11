clc
clear 
close all


syms z n

% Define X1(z) and X2(z)
X1 = z / (z - 0.9);
X2 = z / (z + 6);

% Multiply to get Y(z)
Y = X1 * X2;

% Inverse Z-transform
y_n = iztrans(Y, z, n)