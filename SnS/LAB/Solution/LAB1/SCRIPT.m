% Program to understand the use of script file 

t=-5:0.1:5; 
f=t.*cos(2*pi*t); 
plot(t,f) 

%{
----------------------------------------------------------
| Feature         | Functions                      | Scripts                      |
----------------------------------------------------------
| Input/Output   | Accept input & return output   | No direct input/output       |
----------------------------------------------------------
| Workspace      | Separate (local variables)     | Base workspace (global vars) |
----------------------------------------------------------
| File Name      | Must match function name       | Can have any name            |
----------------------------------------------------------
| Reusability    | Reusable with different inputs | Runs sequentially once       |
----------------------------------------------------------
| Use Case       | Modular, reusable code         | Quick execution, setup       |
----------------------------------------------------------
%}





