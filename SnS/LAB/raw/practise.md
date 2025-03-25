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
# **Fundamental Period and GCD Calculation for Signals**

## **1. Fundamental Period of a Single Function**
For a simple trigonometric function of the form:

`x(t) = cos(ωt)` or `x(t) = sin(ωt)`

The fundamental period **T** is given by:

`T = 2π / ω`

where `ω` is the angular frequency.

### **Example:**
For `x(t) = cos(3t)`, the period is:
`T = 2π / 3`

---

## **2. Fundamental Period for Multiple Frequency Components**
If a signal consists of multiple frequency components, such as:

`x(t) = cos(t) + sin(3t)`

### **Steps to Find the Fundamental Period:**
1. **Determine Individual Periods:**
   - `T1 = 2π` for `cos(t)`
   - `T2 = 2π / 3` for `sin(3t)`

2. **Find the Least Common Multiple (LCM) of the Periods:**
   - Compute the **GCD (Greatest Common Divisor)**:
     `GCD(2π, 2π/3) = 2π/3`
   
   - Use the **LCM formula**:
     `LCM(T1, T2) = |T1 × T2| / GCD(T1, T2)`
   
   - Substituting values:
     `LCM(2π, 2π/3) = (2π × 2π/3) / (2π/3) = 2π`
   
3. **Conclusion:**
   - The fundamental period is **`T = 2π`**.
   - If we need to plot over three periods, we set the time range as `0 ≤ t ≤ 6π`.

---

## **3. MATLAB Code for Plotting the Signal**
To visualize the signal `x(t) = cos(t) + sin(3t)` over three periods:

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

## **4. Understanding GCD for Signal Periods**

### **1. What is GCD (Greatest Common Divisor)?**
The **GCD** of two numbers is the **largest number that divides both numbers exactly**.

### **Example:**
```markdown
GCD(6, 2) = 2
```
This is because **2 is the largest number that evenly divides both 6 and 2**.

---

### **2. Why is GCD(2π, 2π/3) = 2π/3?**
#### **Step-by-Step Calculation:**
We are given two fundamental periods:
```markdown
T1 = 2π  (for cos(t))
T2 = 2π/3 (for sin(3t))
```
#### **Step 1: Factor Out the Common Terms**
```markdown
T1 = 2π × 1
T2 = 2π × (1/3)
```
The common factor is **2π**.

#### **Step 2: Find the Greatest Common Factor**
The GCD is determined by the **smallest coefficient (1 vs. 1/3)**:
```markdown
GCD(1, 1/3) = 1/3
```
Multiplying by the common factor **2π**:
```markdown
GCD(2π, 2π/3) = 2π × (1/3) = 2π/3
```
Thus, **GCD(2π, 2π/3) = 2π/3**.

---

## **5. GCD of Continuous-Time Periodic Signals**

### **1. Basic Case: GCD of Two Integer Multiples of π**
#### Example: **GCD(6π, 3π)**
- Factor out `π`:
  ```
  GCD(6π, 3π) = π × GCD(6,3)
  ```
- Since `GCD(6,3) = 3`, we get:
  ```
  GCD(6π, 3π) = 3π
  ```
✅ **Final Answer:** `3π`

---

### **2. GCD of Mixed Fractions Involving π**
#### Example: **GCD(6π, 2π/3)**
- Convert both terms to a common denominator:
  ```
  6π = 18π/3,  2π/3 = 2π/3
  ```
- Compute **GCD** by factoring out the smallest fraction **π/3**:
  ```
  GCD(18π/3, 2π/3) = (π/3) × GCD(18,2)
  ```
- Since **GCD(18,2) = 2**, we get:
  ```
  GCD(6π, 2π/3) = 2π/3
  ```
✅ **Final Answer:** `2π/3`

---

### **3. Another Example**
#### **Find GCD(8π, 4π/5)**
1. Convert to a common denominator:  
   ```
   8π = 40π/5,  4π/5 = 4π/5
   ```
2. Factor out **π/5**:
   ```
   GCD(40π/5, 4π/5) = (π/5) × GCD(40,4)
   ```
3. Since **GCD(40,4) = 4**, the answer is:
   ```
   GCD(8π, 4π/5) = 4π/5
   ```
✅ **Final Answer:** `4π/5`

---

## **6. General Rule for GCD of Periodic Signals**
For **GCD(Aπ, Bπ/N)** (where A is an integer and B/N is a fraction):
- Convert Aπ into the same denominator as Bπ/N.
- Factor out `π/N`.
- Compute `GCD(A × N, B)`, then multiply by `π/N`.

---

## **7. Conclusion**
- **If both numbers have `π`, factor it out and find the GCD of the coefficients.**
- **If fractions are involved, express them in a common denominator before finding the GCD.**
- **If one term lacks `π`, the GCD may not be meaningful in terms of `π`.**
---


# Causal, Noncausal, and Anticausal Signals

## 1. **Causal Signal**
- A signal is **causal** if its value at any time `t` depends only on present and past values (i.e., it does not depend on future values).
- Mathematically:
  ```math
  x(t) = 0 \quad 	ext{for } t < 0
  ```
- Example: A real-world electrical circuit is usually causal because it cannot respond to an input that hasn't occurred yet.

### MATLAB Implementation:
```matlab
% Causal Signal (t >= 0)
t = 0:0.1:5;
x = t .* exp(-t);
plot(t, x)
title('Causal Signal')
xlabel('t')
ylabel('x(t)')
grid on
```

## 2. **Noncausal Signal**
- A signal is **noncausal** if its value depends on both past and future values.
- This means `x(t)` exists for both `t < 0` and `t > 0`.
- Example: Some ideal filters (e.g., an ideal low-pass filter) require knowledge of future inputs, making them noncausal.

### MATLAB Implementation:
```matlab
% Non-Causal Signal: x(t) = t * exp(-t) for t from -5 to 5
t = -5:0.1:5;
x = t .* exp(-t);
plot(t, x)
title('Non-Causal Signal')
xlabel('t')
ylabel('x(t)')
grid on
```

## 3. **Anticausal Signal**
- A signal is **anticausal** if it depends only on future values of `t` and not on past or present values.
- Mathematically:
  ```math
  x(t) = 0 \quad 	ext{for } t > 0
  ```
- Example: A system that predicts future behavior based only on future values is anticausal, but such systems are not physically realizable.

### MATLAB Implementation:
```matlab
% Anti-Causal Signal (t <= 0)
t = -5:0.1:0;
x = t .* exp(-t);
plot(t, x)
title('Anti-Causal Signal')
xlabel('t')
ylabel('x(t)')
grid on
```

## 4. **Summary**
| Type       | Depends on Past? | Depends on Present? | Depends on Future? |
|------------|----------------|----------------------|--------------------|
| Causal     | ✅ Yes         | ✅ Yes               | ❌ No             |
| Noncausal  | ✅ Yes         | ✅ Yes               | ✅ Yes            |
| Anticausal | ❌ No         | ❌ No               | ✅ Yes            |


# 1. Causal System
- A system or signal is **causal** if its output at any time `t` depends only on present and past inputs (i.e., it does not depend on future values).
- Mathematically, a system is causal if:
  ```
  h(t) = 0  for t < 0
  ```
- Example: A real-world electrical circuit is usually causal because it cannot respond to an input that hasn't occurred yet.

# 2. Noncausal System
- A system or signal is **noncausal** if its output depends on future inputs.
- This means that `h(t)` has values for `t < 0`.
- Example: Some ideal filters (e.g., an ideal low-pass filter) require knowledge of future inputs, making them noncausal.

# 3. Anticausal System
- A system or signal is **anticausal** if it depends only on future values of the input and not on past or present values.
- Mathematically:
  ```
  h(t) = 0  for t > 0
  ```
- Example: A system that predicts future behavior based only on future values is anticausal, but such systems are not physically realizable.

## Example System Classification
Consider the system equation:
``` 
y(t) = x(t+2) + x(t) + x(t-1)
```
- **`x(t+2)`** → Future input (t+2)
- **`x(t)`** → Present input (t)
- **`x(t-1)`** → Past input (t-1)

Since the system depends on a **future value** `x(t+2)`, it is **not causal**. Since it also includes a past value `x(t-1)`, it is **not purely anticausal** either. The system is **noncausal** because it relies on past, present, and future inputs.

---
# Even and Odd Decomposition of Signals in MATLAB

## **Concept of Even and Odd Decomposition**
A signal `x(n)` can be decomposed into its **even** and **odd** components using the formulas:

```
x_even(n) = (x(n) + x(-n)) / 2
x_odd(n) = (x(n) - x(-n)) / 2
```

where:
- `x_even(n)` is the symmetric part.
- `x_odd(n)` is the anti-symmetric part.
- The original signal can be reconstructed as:
  
  ```
  x(n) = x_even(n) + x_odd(n)
  ```

## **Even and Odd Nature of Signals**
A signal is **even** if:
```
x(n) = x(-n)
```
Example: `x(n) = n^2`

A signal is **odd** if:
```
x(n) = -x(-n)
```
Example: `x(n) = n^3`

To determine whether a signal is even, odd, or neither, we compute `x(-n)` and check if it satisfies the above properties.

## **Checking Even and Odd Functions in MATLAB**

### **Problem Statement**
Determine whether the functions `x(t) = t^2` and `y(t) = t^3` are even or odd using MATLAB.

### **MATLAB Code**
```matlab
clc; clear; close all;

% Define time range
t = -10:0.1:10;

% Define functions
x_t = t.^2;  % x(t) = t^2
y_t = t.^3;  % y(t) = t^3

% Compute x(-t) and y(-t)
x_neg_t = (-t).^2;  % x(-t)
y_neg_t = (-t).^3;  % y(-t)

% Check even or odd properties
x_even = isequal(x_t, x_neg_t);   % If x(t) == x(-t), then it's even
y_odd = isequal(y_t, -y_neg_t);   % If y(t) == -y(-t), then it's odd

% Display results
if x_even
    disp('x(t) = t^2 is an even function.');
else
    disp('x(t) = t^2 is not even.');
end

if y_odd
    disp('y(t) = t^3 is an odd function.');
else
    disp('y(t) = t^3 is not odd.');
end

% Plot the functions
figure;
subplot(2,1,1);
plot(t, x_t, 'b', t, x_neg_t, 'r--');
title('x(t) = t^2 and x(-t)');
legend('x(t)', 'x(-t)');
grid on;

subplot(2,1,2);
plot(t, y_t, 'g', t, -y_neg_t, 'm--');
title('y(t) = t^3 and -y(-t)');
legend('y(t)', '-y(-t)');
grid on;
```

### **Expected Output**
- `x(t) = t^2 is an even function.`
- `y(t) = t^3 is an odd function.`
- The plots will visually confirm these properties.

## **Even and Odd Decomposition of Unit Step Function**

### **MATLAB Implementation**
Below is a MATLAB script demonstrating even-odd decomposition for the unit step function:

```matlab
clc; clear; close all;

% Define discrete time range
n = -10:10;

% Define Unit Step Function u(n)
u_n = (n >= 0);  % u(n) = 1 for n >= 0, else 0
u_neg_n = (-n >= 0); % u(-n) = 1 for n <= 0, else 0

% Compute even and odd parts for unit step
y_even = (u_n + u_neg_n) / 2;
y_odd = (u_n - u_neg_n) / 2;
y_reconstructed = y_even + y_odd;

% Plot Unit Step Function
figure;
subplot(2,2,1);
stem(n, u_n, 'b', 'filled');
title('Unit Step Function u(n)'); xlabel('n'); ylabel('u(n)'); grid on;

subplot(2,2,2);
stem(n, y_even, 'r', 'filled');
title('Even Part of u(n)'); xlabel('n'); ylabel('u_{even}(n)'); grid on;

subplot(2,2,3);
stem(n, y_odd, 'g', 'filled');
title('Odd Part of u(n)'); xlabel('n'); ylabel('u_{odd}(n)'); grid on;

subplot(2,2,4);
stem(n, y_reconstructed, 'm', 'filled');
title('Reconstructed u(n) from Even & Odd'); xlabel('n'); ylabel('u(n)'); grid on;
```

## **Conclusion**
- The decomposition is verified successfully for a general signal and the unit step function.
- This method is useful for analyzing signal properties in signal processing applications.

