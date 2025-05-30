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
        
        
% unfiltered
        clc 
        clear
        close all
        T= 2*pi/3;
        t=linspace(0,2*T,100);
        y=exp(3j*t);
        
        real_y = real(y);
        img_y= imag(y);
        plot (t,real_y)
        hold on 
        plot (t,img_y)
        hold off
        