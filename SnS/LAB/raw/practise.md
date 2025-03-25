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

# Super title
	% Add Super Title for all subplots
	sgtitle('Super title');
	
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
# Heaviside(unit step)
- for unit step function (function who are 1 at +ive side)
```
	t=-5:0.01:5;
	
	x=heaviside(t)
	plot(t,x)
	axis([-8 8 -0.1 1.2])
	
		
	t = -5:0.01:5;
	t0 = 2;
	x = heaviside(t - t0); // two step delay means step start at 2 not 0
```
# Dirac,Guspulse(unit impulse)
- dirac
```
		t=-3:0.1:3
		y= inf==dirac(t)
		plot(t,y)
		xlabel('Time')
		ylabel('Amplitude')
	title('Unit impulse using dirac(t)')
```
- gauspulse
```
	
```

# Even Odd

- even = (x(t)+x(-t))/2
- odd = (x(t)-x(-t))/2
```
	t= 0:0.1:20;
	x=t.*exp(-0.1*t).*cos(t);
	x_e=0.5*(x+flip(x));
	x_o=0.5*(x-flip(x));
	x_eo=x_e+x_o;
	
	hold on
	plot(t,x)
	plot(t,x_e)
	plot(t,x_o)
	plot(t,x_eo)
	hold off
```

# Transformations
```
	% Define original piecewise function x(t)
	t1 = 0:0.01:2;
	x1 = t1;
	t2 = 2:0.01:4;
	x2 = 4 - t2;
	
	% Full x(t)
	t = [t1, t2];
	x = [x1, x2];
	
	% Define transformations
	t_neg = -t;        % x(-t)
	t_scale = t / 2;   % x(t/2)
	t_shift_scale1 = (2 + 4*t);  % x(2 + 4t)
	t_shift_scale2 = (-2 - 4*t); % x(-2 - 4t)
	
	% Plot original signal x(t)
	
	subplot(3,2,1);
	plot(t, x, 'b', 'LineWidth', 2);
	
	
	% Plot x(-t) (Time reversal)
	subplot(3,2,2);
	plot(t_neg, x, 'r', 'LineWidth', 2);
	
	
	% Plot x(t/2) (Time scaling)
	subplot(3,2,3);
	plot(t_scale, x, 'g', 'LineWidth', 2);
	
	% Plot x(2 + 4t) (Time scaling and shifting)
	subplot(3,2,4);
	plot(t_shift_scale1, x, 'm', 'LineWidth', 2);
	
	
	% Plot x(-2 - 4t) (Time reversal, scaling, and shifting)
	subplot(3,2,5);
	plot(t_shift_scale2, x, 'c', 'LineWidth', 2);
	
```



# **Fundamental Period and LCM Calculation for Signals**


## **1. Fundamental Period of a Single Function**
For a simple trigonometric function of the form:

\[ x(t) = \cos(\omega t) \quad \text{or} \quad x(t) = \sin(\omega t) \]

The fundamental period \(T\) is given by:

\[ T = \frac{2\pi}{\omega} \]

where \( \omega \) is the angular frequency.

### **Example:**
For \( x(t) = \cos(3t) \), the period is:
\[ T = \frac{2\pi}{3} \]

---

## **2. Fundamental Period for Multiple Frequency Components**
If a signal consists of multiple frequency components, such as:

\[ x(t) = \cos(t) + \sin(3t) \]

### **Steps to Find the Fundamental Period:**
1. **Determine Individual Periods:**
   - \( T_1 = 2\pi \) for \( \cos(t) \)
   - \( T_2 = \frac{2\pi}{3} \) for \( \sin(3t) \)

2. **Find the Least Common Multiple (LCM) of the Periods:**
   - Compute the **GCD (Greatest Common Divisor)**:
     \[ \gcd(2\pi, \frac{2\pi}{3}) = \frac{2\pi}{3} \]
   
   - Use the **LCM formula**:
     \[ \text{LCM}(T_1, T_2) = \frac{|T_1 \cdot T_2|}{\gcd(T_1, T_2)} \]
   
   - Substituting values:
     \[ \text{LCM}(2\pi, \frac{2\pi}{3}) = \frac{(2\pi) \times (\frac{2\pi}{3})}{\frac{2\pi}{3}} = 2\pi \]
   
3. **Conclusion:**
   - The fundamental period is **\( T = 2\pi \)**.
   - If we need to plot over three periods, we set the time range as \( 0 \leq t \leq 6\pi \).

---

## **3. MATLAB Code for Plotting the Signal**
To visualize the signal \( x(t) = \cos(t) + \sin(3t) \) over three periods:

```matlab
clc;
clear;
close all;

% Time range for three periods
T = 2*pi; % Fundamental period
t = linspace(0, 3*T, 1000); % Fine time step

% Signal Definition
x_t = cos(t) + sin(3*t);

% Plot the signal
plot(t, x_t, 'b', 'LineWidth', 1.5);
xlabel('Time (t)');
ylabel('x(t)');
title('Plot of x(t) = cos(t) + sin(3t)');
grid on;
```
This code will generate a smooth plot of the signal over three complete periods.

---

## **4. Summary**
- **Single component signals** have a period of \( \frac{2\pi}{\omega} \).
- **Multiple component signals** require the **LCM** of individual periods to find the fundamental period.
- **MATLAB can be used to plot signals** over multiple periods for visualization.

---

This guide provides a structured approach to finding and plotting the fundamental period of signals. 🚀

