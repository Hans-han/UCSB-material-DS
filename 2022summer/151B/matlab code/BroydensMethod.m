%% Broyden's Method

%% Input Information

F = @(x) [3*x(1)-cos(x(2)*x(3))-1/2;
          x(1)^2-81*(x(2)+0.1)^2+sin(x(3))+1.06;
          exp(-x(1)*x(2))+20*x(3)+(10*pi-3)/3];

J = @(x) [3, x(3)*sin(x(2)*x(3)), x(2)*sin(x(2)*x(3));
          2*x(1), -162*(x(2)+0.1), cos(x(3));
          -x(2)*exp(-x(1)*x(2)), -x(1)*exp(-x(1)*x(2)), 20];

x = [0.1;
     0.1;
     -0.1];

tol = 1e-5;                 % tolerance, 1e-4 = 10^{-4}

max_iter = 10;              % max number of iterations

%% Broyden's Method

fprintf('i\tx1\t\tx2\t\tx3\t\tinf error\n');          % for display
fprintf('%d\t%f\t%f\t%f\n',0,x(1),x(2),x(3));

A0 = J(x);
v = F(x);

A = inv(A0);    % inv in general is really expensive

s = -A*v;
x = x+s;
k = 2;

fprintf('%d\t%f\t%f\t%f\n',1,x(1),x(2),x(3));

while( k <= max_iter)

    w = v;
    v = F(x);
    y = v-w;

    z = -A*y;
    
    p = -transpose(s)*z;

    u = transpose(s)*A;

    A = A +(1/p)*(s+z)*u;

    s = -A*v;

    x = x+s;
    
    % calculate infty norm
    inf_error = max(abs(s));

    % display information
    fprintf('%d\t%f\t%f\t%f\t%f\n',k,x(1),x(2),x(3),inf_error);    % displays iteration i, p_i
    
    % check stopping condition 
    if(inf_error < tol)
        break;
    end
    
    % increase iteration count
    k = k + 1;
    
end
