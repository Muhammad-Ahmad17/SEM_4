clc
clear
close all


num = [12 -38 11 3 54];    
den = [1 -5 6];            

[r, p, k] = residuez(num, den)

tf (num,den,-1)


