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


#  plot more than one diagram in a single plot
	plot(x,cos(x),'b*',x,sin(x),'r.');  // b* -> blue staric && r, -> red dot 
# hold on & hold off
	x = linspace(0, 2*pi, 100);
	plot(x, cos(x), 'b*');
	hold on;
	plot(x, sin(x), 'r.');
	hold off;
- above 	both are same

# subplot
	subplot(311) // (rows,coloum,plot_no) 
	plot (x,y1)
	subplot(312)
	plot (x,y2)
	subplot(313)
	plot (x,y3)
	
# figure
	plot (x,y1)
	figure         // to hold the 
	plot (x,y2)
	figure
	plot (x,y3)

# labeling 
	xlabel('time');
	ylabel('amplitude');
	title('sin and cos function');
	legend('cos','sin');  // LEGEND ME JIS CHIZ KA GRAPH DRAW KIA H AUS KO LIKHTY HN (X-AXIS , Y-AXIS)
	

## discrete ploting
	a=0:10 // default increment 
	// a=0:0.01:10 // 0.01 increment
	b=a.^2
	stem (a,b)
	
# piecewise ploting
	t1=-2:.01:2;
	t2=2.1:.01:4.9;
	t3=5:.01:8;
	
	f1 = ones(size(t1)); 
	f2 = zeros(size(t2));
	f3 = t3 .* sin(4 * pi * t3);
	t=[t1 t2 t3]; 
	f=[f1 f2 f3];
	plot(t,f) 
	
# axis settings
	axis([0 10 -1 1]) -- to set the axis zoom in or select the specific region
	
# periods
	Find (w) (angular frequency).
	Use (T = 2*pi/w) to get the period.
	Check if shifting by T keeps the signal the same.
	
```
		% Fundamental period
		T = 2*pi/3;  % w = 3
		
		% Two periods
		t = linspace(0, 2*T, 100);
		
		% Compute the complex exponential signal
		y = exp(3j*t);   
		
		% Extract real and imaginary parts
		y_real = real(y);
		y_imag = imag(y);
		
		% Plot real and imaginary parts separately
		figure;
		plot(t, y_real, 'b', 'LineWidth', 1.5); hold on;
		plot(t, y_imag, 'r', 'LineWidth', 1.5);
		grid on;
		
		% Labels and title
		xlabel('Time (t)'); 
		ylabel('Amplitude'); 
		title('Real and Imaginary Parts of y(t) = e^{3jt}');
		
		% Legend
		legend('Real Part: cos(3t)', 'Imaginary Part: sin(3t)');
		
		% Hold off to stop plotting
		hold off;
```
# Heaviside
- for unit step function (function who are 1 at +ive side)
```
	t=-5:0.01:5;
	
	x=heaviside(t)
	plot(t,x)
	axis([-8 8 -0.1 1.2])
	
		
	t = -5:0.01:5;
	t0 = 2;
	x = heaviside(t - t0); // two step advance just
```
# Dirac
