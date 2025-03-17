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
** both are same

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
	