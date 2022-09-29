% Author: Ryan Arbon
% Date: August 9, 2022
% Program: implements Taylor's method of order two in Matlab for demonstration purpose
% solving Exercise 5.3.5(c)

%% The relevant functions and problem parameters

% Function defining the ODE y '=f(t,y)
f = @(t,y) (y/t)-(y/t)^2;

% Derivative of the defining function df/dy
df = @(t,y) (y*t-2*t*y)/(t^3);

% The true solution
%F = @(t) (2*t) ./ (1-2*t);

% Function for finding the theoretical maximum error
err_th = @(t, h, M, L, a) (h^2)*M/(6*L) *(exp(L*(t - a)) - 1);

t_start = 1;               % Initial time
t_end = 1.2;               % Final time
y_start = 1.0;            % Initial value of y
N = 10;                     % Number of timesteps to take

L = 2;
M = 8;

%% Numerically solve, compute the true solution, and find the error

%[w,t,h] = taylorTwo(t_start, t_end, y_start, N, f, df);

%y = F(t);

%glob_err = err_th(t,h,M, L, t_start); % True error
%true_err = abs(y - w);                         % Theoretical error maximum

%% Plot the computed solution and the true solution
% plot(t,w, '*-');
% hold on;
% plot(t, y, '*-');
% hold off;
%  
% xlabel('t');
% ylabel('w');
% title('Approximate solution w_i v.s times t_i with h = 0.5');
% ylabel('w and y');
% title('w_i and y(t) v.s times t_i with h = 0.1')
 
%% Plot the error
plot(t, true_err, '*-');
hold on;
plot(t, glob_err, '*-');
hold off;
xlabel('t');
ylabel('True error (blue) and theoretical error (orange)');
title('Comparison of error terms with h = 0.1');

%% The function implementing Euler
function [w, t, h] = taylorTwo(t_start, t_end, y_start, N, f, df)
    h = (t_end - t_start)/N;   % Timestep size

    t = zeros(N+1,1);             % Initialize arrays
    w = zeros(N+1,1);
    
    t(1) = t_start;             % Initial conditions
    w(1) = y_start;
    
    for i = 1:(N)                 % Begin looping
        t(i+1) = t(i) + h;
        w(i+1) = w(i) + h*f(t(i),w(i)) + ((h^2)/2)*f(t(i),w(i))*df(t(i),w(i));
    end
    
end