% Author: Ryan Arbon
% Date: August 29, 2022
% Program: implements the linear shooting method for a degree two boundary
% value problem, solving 11.1.3(c)

%% Set up the problem parameters

% Defining functions for the first system
f1 = @(x,y1,y2) y2;
f2 = @(x,y1,y2) 2*y2 - y1 + x* exp(x) - x;

% Defining functions for the second system
g1 = @(x,y1,y2) y2;
g2 = @(x,y1,y2) 2*y2 - y1;

t_start = 0;
t_end = 1;
a1 = [-1 0];
a2 = [0 1];

h = 0.1;


%% Compute the approximation to each IVP and then the approx to the BVP
[u1,u2,x,N] =  rk4syst(t_start,t_end,a1,f1,f2,h);
[v1,v2,x,N] =  rk4syst(t_start,t_end,a2,g1,g2,h);

% Now compute the approximation to the IVP:
w1 = u1 - u1(N+1)/v1(N+1)*v1;

% And its derivative if you want
w2 = u2 - u2(N+1)/v2(N+1)*v2;


%% Plot w1 and y and print
plot(x, w1 ,'b*-');
xlabel('x');
ylabel('y');


fprintf('i\t \tt_i \t\t\t w_1,i \t\n')
for i= 1:(N+1)
    fprintf('%d\t  %.9f\t  %.9f\t\n', i-1, t(i), w1(i));
end


%% The function implementing Runge-Kutta 4 for a system of 2 equations
function [w1, w2,t,N] = rk4syst(t_start,t_end,a,f1,f2,h)

    N = int16((t_end - t_start)/h);

    t = zeros(N+1,1);          % Initialize arrays
    w1 = zeros(N+1,1);
    w2 = zeros(N+1,1);
    
    t(1) = t_start;            % Initial conditions
    w1(1) = a(1);
    w2(1) = a(2);
    
    for i = 1:(N)              % Begin looping
        t(i+1) = t(i) + h;
        
        k11 = h * f1(t(i), w1(i), w2(i)); 
        k12 = h * f2(t(i), w1(i), w2(i)); 
        
        k21 = h * f1(t(i) + h/2, w1(i) + k11/2, w2(i) + k12/2);
        k22 = h * f2(t(i) + h/2, w1(i) + k11/2, w2(i) + k12/2);
        
        k31 = h * f1(t(i) + h/2, w1(i) + k21/2, w2(i) + k22/2);
        k32 = h * f2(t(i) + h/2, w1(i) + k21/2, w2(i) + k22/2);
        
        k41 = h * f1(t(i+1), w1(i) + k31, w2(i) + k32);
        k42 = h * f2(t(i+1), w1(i) + k31, w2(i) + k32);
        
        w1(i+1) = w1(i) + (k11 + 2*k21 + 2*k31 + k41)/6;
        w2(i+1) = w2(i) + (k12 + 2*k22 + 2*k32 + k42)/6;
        
    end
end