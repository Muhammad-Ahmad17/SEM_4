# Complex Exponential Signals

### Fundamental Period and Angular Frequency

The complex exponential signal can be described as:

$$ y(t) = e^{jw t} $$

Where:
- `w` is the angular frequency in radians per second.
- `T` is the period of the signal, and it is related to the angular frequency as:

$$ T = \frac{2\pi}{w} $$

For this example, the angular frequency `w` is chosen to be 3. Using the above formula:

$$ T = \frac{2\pi}{3} $$

Thus, the fundamental period of the signal is \( T = \frac{2\pi}{3} \).

### Shifting by One Period
To check whether shifting the signal by one period `T` keeps the signal the same, we can generate the signal for two periods: from \( t = 0 \) to \( t = 2T \). The signal's behavior over one period will be compared with its behavior over the next period to verify if the periodicity holds.

### MATLAB Code Implementation

Below is the MATLAB code that computes the complex exponential signal and plots its real and imaginary parts.

```matlab
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
# Comparison of Continuous, Discrete, and Digital Signals in MATLAB

---

## 1. Continuous Signal
A continuous signal is defined over a continuous range of time. In MATLAB, it can be visualized using smooth functions like `cos(t)` with small time increments.

### Code:
```matlab
% Continuous Signal
t1 = -113:0.1:113;
x1 = cos(t1);

subplot(311)
plot(t1, x1);
axis([-10 10 -1 1])
title('Continuous Signal')
```

- **Time**: Continuous (fractional values allowed)
- **Representation**: Smooth curve
- **Plot Function**: `plot`

---

## 2. Discrete Signal
A discrete signal is defined at discrete time intervals, but the amplitude can be continuous. Even though the time steps may seem continuous, the representation (using `stem`) shows individual sample points.

### Code:
```matlab
% Discrete Signal
n1 = -113:0.1:113;
x2 = cos(n1);

subplot(312)
stem(n1, x2);
axis([-10 10 -1 1])
title('Discrete Signal')
```

- **Time**: Discrete but possibly non-integer
- **Amplitude**: Continuous
- **Plot Function**: `stem`

---

## 3. Digital Signal
A digital signal is both discrete in time and amplitude. Here, we approximate it using cosine values at integer time steps.

### Code:
```matlab
% Digital Signal
t = -113:113;
x = cos(t);
round_x= round(x);

subplot(313)
stem(t, round_x);
axis([-10 10 -1 1])
title('Digital Signal')
```

- **Time**: Discrete (integer values)
- **Amplitude**: Approximated/discrete
- **Plot Function**: `stem`

---

## Summary Table
| Feature         | Continuous Signal       | Discrete Signal           | Digital Signal            |
|----------------|--------------------------|----------------------------|----------------------------|
| **Time**       | Continuous (real values) | Discrete (any steps)      | Discrete (integer steps)  |
| **Amplitude**  | Continuous               | Continuous                | Discrete (quantized)      |
| **Representation** | Smooth curve         | Sampled with lines         | Sampled with quantization |
| **MATLAB Plot**| `plot`                   | `stem`                    | `stem`                    |

---

## Visualization
The subplot structure used in MATLAB creates a single figure with three plots stacked vertically to compare:
1. Continuous signal using `plot`
2. Discrete signal using `stem` (fractional step)
3. Digital signal using `stem` (integer steps)

This clear visual representation helps understand the conceptual and practical differences between the signal types.

# Unit Step and Impulse Signals in MATLAB

This Markdown document demonstrates how to generate and visualize **Unit Step** and **Unit Impulse** signals using MATLAB.

---

## 1. Unit Step Signal (Heaviside Function)
The unit step function is often represented as `u(t)` and implemented using the `heaviside()` function in MATLAB.

### MATLAB Code:
```matlab
clc;
clear;
close all;

t = -5:0.01:5;
x = heaviside(t);

plot(t, x);
axis([-8 8 -0.1 1.2])
title('Unit Step Function');
xlabel('Time');
ylabel('Amplitude');
```

### Description:
- The `heaviside(t)` function returns:
  - 0 for `t < 0`
  - 1 for `t > 0`
  - 0.5 at `t = 0`
- The graph represents a sudden jump from 0 to 1 at `t = 0`.

---

## 2. Shifted Unit Step Signal
You can shift the step signal using `heaviside(t - t0)`.

### MATLAB Code:
```matlab
t = -5:0.01:5;
t0 = 2;
x = heaviside(t - t0);

plot(t, x);
title('Shifted Unit Step Function');
xlabel('Time');
ylabel('Amplitude');
```

---

## 3. Unit Impulse Signal (Dirac Delta Function)
The unit impulse signal is a mathematical idealization represented using `dirac(t)` in MATLAB. It is infinite at `t = 0` and zero elsewhere.

### MATLAB Code:
```matlab
clc;
clear;
close all;

t = -3:0.1:3;
y = inf == dirac(t);

plot(t, y);
xlabel('Time');
ylabel('Amplitude');
title('Unit Impulse using dirac(t)');
```

### Description:
- `dirac(t)` returns `Inf` at `t = 0`, and 0 elsewhere.
- Since `Inf` cannot be plotted directly on a normal scale, the expression `inf == dirac(t)` is used to generate a **logical (boolean) array**.
  - It checks if each value of `dirac(t)` is infinite.
  - The result is `1` (true) where the value is `Inf` (at `t = 0`), and `0` (false) elsewhere.
  - This makes it easy to **visualize** the unit impulse as a sharp spike at the origin.

---

## Summary
| Signal Type      | MATLAB Function | Description                            |
|------------------|------------------|----------------------------------------|
| Unit Step        | `heaviside(t)`   | Jumps from 0 to 1 at `t = 0`           |
| Shifted Step     | `heaviside(t-t0)`| Step occurs at `t = t0`                |
| Unit Impulse     | `dirac(t)`       | Infinite spike at `t = 0`              |

These signals are essential in signal processing, control systems, and system response analysis.

