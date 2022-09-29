% Author: Ryan Arbon
% Date: August 9, 2022
% Program: implements Runge-Kutta for a system of 2 differential equations.
% Applies this method to Exercise 5.9.1(b)

%% Set up the problem parameters
t_start = 0;
t_end = 1;
alpha = [1,1];
h = 0.2;


%% Compute the approximation, the true solution, and the error
[s,t,N] =  rk4(t_start, t_end,alpha,h);
true_soln = F(t);
err = zeros(N+1,1);
for i = 1:(N+1)
    err(i) = norm(s(i,:) - true_soln(i,:));
end

ts = zeros(100,1);
ts(:,1) = linspace(t_start,t_end).';
S = F(ts);


%% Plot the system in phase space
plot(s(:,1), s(:,2),'b*-');
hold on;
plot(S(:,1), S(:,2));
legend('Approximate Solution', 'True Solution');
xlabel('u_1');
ylabel('u_2');
hold off

%% Print the errors

fprintf('i\t \tt_i \t\t\t w_1,i \t\t\t u_1,i \t\t\t w_2,i \t\t\t y_2,i \t\t\t err_i \n')
for i= 1:(N+1)
    fprintf('%d\t  %.9f\t  %.9f\t  %.9f\t  %.9f\t  %.9f\t  %.9f\t\n', i-1, t(i), s(i,1), true_soln(i,1), s(i,2), true_soln(i,2), err(i));
end


%% The vector valued function of 2 equations defining the system of ODEs
function s = f(t,r)
   s(1) = 3*r(1) + 2*r(2) -(2*t^2+1)*exp(2*t);
   s(2) = 4*r(1) + r(2) - (t^2+2*t-4)*exp(2*t);
end

%% The vector valued true solution
function S = F(t)
    S(:,1) = (1/3)*exp(5*t) - (1/3)*exp(-t) + exp(2*t);
    S(:,2) = (1/3)*exp(5*t) + (2/3) * exp(-t) + (t.*t).*exp(2*t);
end


%% The function implementing Runge-Kutta 4 for a system of 2 equations
function [w,t,N] = rk4(t_start,t_end,alpha,h)

    N = int16((t_end - t_start)/h);

    t = zeros(N+1,1);          % Initialize arrays
    w = zeros(N+1,2);
    
    t(1) = t_start;            % Initial conditions
    w(1,:) = alpha;
    
    for i = 1:(N)              % Begin looping
        t(i+1) = t(i) + h;
        
        k1 = h * f(t(i), w(i,:));      
        k2 = h * f(t(i) + h/2, w(i,:) + k1/2);
        k3 = h * f(t(i) + h/2, w(i,:) + k2/2);
        k4 = h * f(t(i+1), w(i,:) + k3);
        
        w(i+1,:) = w(i,:) + (k1 + 2*k2 + 2*k3 + k4)/6;
        
    end
end