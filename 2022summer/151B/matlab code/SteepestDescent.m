%% Steepest Descent Method

%% Input information

x = [0;
     0;
     0];

tol = 0.01;

max_iter = 7;

J = @(x) [3, x(3)*sin(x(2)*x(3)), x(2)*sin(x(2)*x(3));
          2*x(1), -162*(x(2)+0.1), cos(x(3));
          -x(2)*exp(-x(1)*x(2)), -x(1)*exp(-x(1)*x(2)), 20];

F = @(x) [3*x(1)-cos(x(2)*x(3))-1/2;
          x(1)^2-81*(x(2)+0.1)^2+sin(x(3))+1.06;
          exp(-x(1)*x(2))+20*x(3)+(10*pi-3)/3];

f1 = @(x) 3*x(1)-cos(x(2)*x(3))-1/2;
f2 = @(x) x(1)^2-81*(x(2)+0.1)^2+sin(x(3))+1.06;
f3 = @(x) exp(-x(1)*x(2))+20*x(3)+(10*pi-3)/3;

g = @(x) f1(x)^2 + f2(x)^2 + f3(x)^2;

%% Steepest Descent Method

k = 1;

fprintf('k\t\tx1\t\tx2\t\tx3\tg \n')
fprintf('%d\t%f\t%f\t%f\n',0,x(1),x(2),x(3))

while( k <= max_iter)

    g1 = g(x);
    z = 2*transpose(J(x))*F(x);
    z0 = norm(z);

    if(z0 == 0)
        fprintf('Zero gradient.')
        fprintf('%d\t%f\t%f\t%f\t%f\n',k,x(1),x(2),x(3),g1)
        break;
    end

    z = z/z0;
    alpha1 = 0;
    alpha3 = 1;
    g3 = g(x - alpha3*z);

    while(g3 >= g1)
        alpha3 = alpha3/2;
        g3 = g(x - alpha3*z);
        if(alpha3 < tol/2)
            fprintf('No likely improvement.')
            fprintf('%d\t%f\t%f\t%f\t%f\n',k,x(1),x(2),x(3),g1)
            break;
        end
    end

    alpha2 = alpha3/2;
    g2 = g(x - alpha2*z);

    h1 = (g2-g1)/alpha2;
    h2 = (g3-g2)/(alpha3-alpha2);
    h3 = (h2-h1)/alpha3;

    alpha0 = 0.5*(alpha2 - h1/h3);
    g0 = g(x - alpha0*z);

    if(g0 <= g3)
        g_min = g0;
        alpha = alpha0;
    else
        g_min = g3;
        alpha = alpha3;
    end

    x = x-alpha*z;

    fprintf('%d\t%f\t%f\t%f\t%f\n',k,x(1),x(2),x(3),g_min);

    if(abs(g_min-g1)<tol)
        break;
    end

    k = k+1;
end







