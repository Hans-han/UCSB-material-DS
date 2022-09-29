% Author: Ryan Arbon
% Date: August 16, 2022
% Program: implements Forwards Euler and Backwards Euler with Newton's
% method for demonstration purposes, solving Exercises 5.11.1(b) and
% 5.11.12(b).

%% The relevant functions and problem parameters to set up the IVP

% Function defining the ODE y' = f(t,y)
f = @(t,x) -20 *(x-t.^2) + 2*t;

% The partial derivative of f with respect to y
df = @(t,x) -20*ones(size(x));


% The true solution
F = @(t) t.^2 + (1/3)*exp(-20*t);

t_start = 0;                    % Initial time
t_end = 1;                      % Final time
y_start = 1/3;                   % Initial value of y

h = 0.1;                        % Time step size
tol = 10^(-6);
MaxIter = 50;


[w1,t,N] = feuler(t_start, t_end, y_start, h, f);
[w2,t,N] = beuler(t_start, t_end, y_start, h, f, df, tol, MaxIter);
y = F(t);

err1 = abs(y-w1);
err2 = abs(y-w2);

%% Plot the computed solution and the true solution

plot(linspace(0,1), F(linspace(0,1)));
hold on;
plot(t, w1, '*-');
plot(t, w2, '*-');
legend("True Solution", "Forward Euler",  "Backward Euler")
hold off

%% Print the associated errors

fprintf('i\t \tt_i \t\t F.EulerError_i \t B.EulerError_i\n')
for i= 1:(N+1)
    fprintf('%d\t  %.9f\t  %.9f\t  %.9f\t\n', i-1, t(i), err1(i), err2(i));
end



%% The function implementing Forward Euler Method
function [w, t, N] = feuler(t_start, t_end, y_start, h, f)
    
    % Number of timesteps to take. Note that we need to cast
    % N to be an integer type.
    
    N = int16((t_end - t_start)/h); 
    t = zeros(N+1,1);           % Initialize arrays
    w = zeros(N+1,1);
    
    t(1) = t_start;             % Initial conditions
    w(1) = y_start;
    
    for i = 1:(N)               % Begin looping
        t(i+1) = t(i) + h;
        w(i+1) = w(i) + h * f(t(i),w(i));
    end
end

%% The function implementing Backward Euler Method
function [w, t, N] = beuler(t_start, t_end, y_start, h, f, df, tol, MaxIter)
    
    % Number of timesteps to take. Note that we need to cast
    % N to be an integer type.
    
    N = int16((t_end - t_start)/h); 
    t = zeros(N+1,1);           % Initialize arrays
    w = zeros(N+1,1);
    
    t(1) = t_start;             % Initial conditions
    w(1) = y_start;
    
    for i = 1:(N)               % Begin looping
        t(i+1) = t(i) + h;
        
        % Start running Newton's method
        FLAG = 0;
        j = 1;
        w_temp = w(i);
        
        while FLAG == 0
            w(i+1) = w_temp - (w_temp - w(i) - h*f(t(i+1),w_temp))/(1 - h*df(t(i+1),w_temp));
            if abs(w(i+1) - w_temp) < tol
                FLAG = 1;
            else
                j = j+1;
                w_temp = w(i+1);
                if j > MaxIter
                    disp("Max number of iterations exceeded")
                    break;
                end
            end        
        end

    end
end
