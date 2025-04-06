# Comparison of Colon Operator (:) and linspace() in MATLAB

## Table of Differences

| Feature             | Colon Operator (`:`)       				  	| `linspace(start, end, num_points)` 		 |
|---------------------|---------------------------------------------|--------------------------------------------|
| **Step Size**       | Fixed (`start:step:end`) 					| Automatically calculated           		 |
| **Number of Points**| Depends on step size    					| Defined by the user                		 |
| **Usage**           | When step size is known  			 		| When a specific number of points is needed |
| **Example**         | `0:2.5:10` → `[0, 2.5, 5, 7.5, 10]` 		| `linspace(0,10,5)` → `[0, 2.5, 5, 7.5, 10]`|
| **Use Case** 		  | When evenly spaced increments are needed 	| When you need a specific number of points	 |

## Conclusion
- Use `:` when you know the **step size**.
- Use `linspace()` when you know **how many points** you need.

---
# Ploting Styles

##  plot more than one diagram in a single plot
```matlab
	plot(x,cos(x),'b*',x,sin(x),'r.');  // b* -> blue staric && r, -> red dot 
```
## hold on & hold off
```matlab
	x = linspace(0, 2*pi, 100);
	plot(x, cos(x), 'b*');
	hold on;
	plot(x, sin(x), 'r.');
	hold off;
```
- above both are same

## subplot
```matlab
	subplot(311) // (rows,coloum,plot_no) 
	plot (x,y1)
	subplot(312)
	plot (x,y2)
	subplot(313)
	plot (x,y3)
```
	
## figure
```matlab
	plot (x,y1)
	figure         // to hold the 
	plot (x,y2)
	figure
	plot (x,y3)
```
## labeling 
```matlab
	xlabel('time');
	ylabel('amplitude');
	title('sin and cos function');
	legend('cos','sin');  // LEGEND ME JIS CHIZ KA GRAPH DRAW KIA H AUS KO LIKHTY HN (X-AXIS , Y-AXIS)
```

# Ploting different type of signals

## continous ploting
```matlab
% Define time vector from 0 to 2*pi with small increments (for smooth curve)
t = 0:0.01:2*pi;
% Define the continuous signal (e.g., sine wave)
y = sin(t);
% Plot the signal
plot(t, y);
```
## discrete ploting
```matlab
	% default increment 
	a=0:10 
	% 0.01 increment 
	a=0:0.01:10 
	b=a.^2
	stem (a,b)
```
## piecewise ploting
```matlab
	t1=-2:.01:2;
	t2=2.1:.01:4.9;
	t3=5:.01:8;
	
	f1 = ones(size(t1)); 
	f2 = zeros(size(t2));
	f3 = t3 .* sin(4 * pi * t3);
	t=[t1 t2 t3]; 
	f=[f1 f2 f3];
	plot(t,f) 
```
# axis settings
```matlab
	axis([0 10 -1 1]) -- to set the axis zoom in or select the specific region
```