%% Fixed-Point Iteration

%% Input Information

G = @(x) [1-cos(x(1)*x(2)*x(3));
          1-(1-x(1))^(1/4)-0.05*x(3)^2+0.15*x(3);
          x(1)^2+0.1*x(2)^2-0.01*x(2)+1];

p0 = [0;
      0.1;
      0.8];

tol = 1e-5;                 % tolerance, 1e-4 = 10^{-4}

max_iter = 30;              % max number of iterations

%% Fixed-Point Iteration

i = 1;                      % iteration count

fprintf('i\tx1\t\tx2\t\tx3\t\tinf error\n');          % for display
fprintf('%d\t%f\t%f\t%f\n',0,p0(1),p0(2),p0(3));

while( i <= max_iter)

    % get p_i 
    p = G(p0);              % p_i 
    
    % calculate infty norm
    inf_error = max(abs(p - p0));

    % display information
    fprintf('%d\t%f\t%f\t%f\t%f\n',i,p(1),p(2),p(3),inf_error);    % displays iteration i, p_i
    
    % check stopping condition 
    if(inf_error < tol)
        break;
    end
    
    % increase iteration count
    i = i + 1;
    
    % prepare for next iteration
    p0 = p;
    
end
