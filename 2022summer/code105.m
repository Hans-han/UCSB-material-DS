%% Set up the problem parameters
f1 = @(x) x(1)^2 - x(2)^2 + 2*x(2);
f2 = @(x) 2*x(1) + x(2)^2 - 6;
F = @(x) [f1(x);f2(x)];
J = @(x) [ 2*x(1),  -2*x(2) + 2;
           2     ,   2*x(2)    ];
N = 1;   
x0 = [0; 0];
x = continuation_rk4(x0, F, J, N)
x0 = [1; 1];
x = continuation_rk4(x0, F, J, N)
%% Function implementing the continuation using Runge-Kutta METHOD>

function x = continuation_rk4(x0, F, J, N)
    h = 1/N;
    x = x0;
    b = - h * F(x);
    
    for i = 1:N
       A = J(x);
       k1 = linsolve(A,b);
       A = J(x+k1/2);
       k2 = linsolve(A,b);
       A = J(x+k2/2);
       k3 = linsolve(A,b);
       A = J(x+k3);
       k4 = linsolve(A,b);
       x = x + (k1+2*k2+2*k3+k4)/6;
       
    end
end
