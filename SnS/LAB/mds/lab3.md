# Checking Periodic Functions using MATLAB Loop

## What is a Periodic Function?
A function `x(t)` is **periodic** if there exists a value `T > 0` such that:

```
x(t) = x(t + T) for all t
```

The smallest such value of `T` is called the **fundamental period**.

---

## MATLAB Approach Using Loop
We use a loop to generate multiple time-shifted versions of a signal and visually inspect their alignment.

### MATLAB Code
```matlab
clc;
clear;
close all;

t = 0:0.01:10;      % Define time vector
T = 1;              % Trial period

for k = 1:10
    xk(k, :) = sin(t + k * T);   % Time-shifted versions of sin(t)
end

% Plot all versions on a single figure
figure;
hold on;
for k = 1:10
    plot(t, xk(k, :));
end
hold off;
title('Visual Check for Periodicity');
xlabel('Time');
ylabel('Amplitude');
```

---

## Description
- We define a sinusoidal function and shift it in time by multiples of `T`.
- If all curves overlap, the function is periodic with period `T`.
- This method is visual and can confirm periodicity for signals like sine, cosine, etc.

---

## Example Output
- If the signal is `sin(t)`, you'll see repeated overlapping curves—confirming periodicity.
- If the signal is `exp(t)`, each curve will differ—showing non-periodicity.

---

## Modify the Code
You can change the function (e.g., `exp(t)`, `cos(3*t)`, etc.) or trial period `T` to test for different functions.

---

## Summary
| Function        | Periodic? | Visual Overlap Result                |
|----------------|-----------|-------------------------------------|
| `sin(t)`       | Yes       | All curves align                     |
| `cos(3*t)`     | Yes       | All curves align                     |
| `exp(t)`       | No        | Curves diverge                       |
| `t^2`          | No        | Curves diverge                       |

This method is especially useful when numerical equality is not suitable due to floating-point precision limits.


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

---


# **Even and Odd Nature of Signals**
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

  ---
# Power and Energy Function

- **Power Function**:
  - A **power signal** is one that has **finite power** but **infinite energy**. This means that the signal doesn't decay over time, and its total energy keeps increasing as time progresses. 
  - An example of a power function is a **periodic signal** (like a sinusoidal function) that repeats indefinitely.

- **Energy Function**:
  - An **energy signal** has **finite energy** but **infinite power**. This type of signal has a finite duration, and its total energy is limited, but its power, when averaged over an infinite time period, becomes infinite.
  - A **unit step function** or a **rectangular pulse** is an example of an energy signal because it has finite energy but doesn't decay, so its power is infinite when averaged over infinite time.

#### In Summary:
- **Power Signal**: Infinite energy, finite power (e.g., periodic sinusoidal signals).
- **Energy Signal**: Finite energy, infinite power (e.g., unit step function, rectangular pulse).

### Full Code Breakdown:

#### Part A:

```matlab
clc;
clear;
close all;

% Define the signal u(t) using heaviside function
syms t T 
x = heaviside(t);

% Energy calculation: integrate squared signal over [-T, T]
d = int(abs(x)^2, t, -T, T); 

% Calculate energy as the limit of the integral as T -> infinity
Ex = limit(d, T, inf);

% Power calculation: average energy over time
Px = limit((1/(2*T)) * d, T, inf);

disp('Energy (Ex):');
disp(Ex);  % Display energy
disp('Power (Px):');
disp(Px);  % Display power
```

1. **Signal**: `x = heaviside(t)` represents the unit step function \( u(t) \).
2. **Energy**: The energy is calculated by integrating \( |x(t)|^2 \) over the interval \([-T, T]\).
3. **Power**: The power is computed by averaging the energy over time.

#### Part B:

```matlab
clc;
clear;
close all;

% Define the rectangular pulse as u(t) - u(t-1)
syms t T
x = heaviside(t) - heaviside(t-1);

% Energy calculation: integrate squared signal over [-T, T]
d = simplify(int(x)^2, t, -T, T);

% Power and Energy calculation
Px = limit((1/(2*T)) * d, T, inf);  
Ex = limit(1 * d, T, inf);

disp('Energy (Ex):');
disp(Ex);  % Display energy
disp('Power (Px):');
disp(Px);  % Display power
```

1. **Signal**: `x = heaviside(t) - heaviside(t-1)` creates a rectangular pulse.
2. **Energy**: The energy is calculated by integrating \( |x(t)|^2 \) over the interval \([-T, T]\).
3. **Power**: The power is computed using the formula for averaging the energy over time.

#### Plotting:

```matlab
t = -5:0.01:5;  % Time vector from -5 to 5

% Define the signals
x1 = heaviside(t);  % Unit step function
x2 = heaviside(t) - heaviside(t-1);  % Rectangular pulse

% Plot the unit step function
subplot(211)
plot(t, x1);
title('u(t)');  % Title for the unit step function plot

% Plot the rectangular pulse
subplot(212)
plot(t, x2);
title('u(t) - u(t-1)');  % Title for the rectangular pulse plot
```

1. **Plot 1**: Shows the unit step function, which is 0 for \( t < 0 \) and 1 for \( t \geq 0 \).
2. **Plot 2**: Displays the rectangular pulse, which is 1 from \( t = 0 \) to \( t = 1 \), and 0 elsewhere.

---

### Conclusion:

This code calculates the **energy** and **power** of two signals:
- The unit step function, which has infinite energy but finite power.
- A rectangular pulse formed by subtracting two shifted unit step functions, which has finite energy and power.

The results are displayed both numerically (via `disp`) and visually (via plots), which helps in understanding the behavior of these signals in terms of energy and power.