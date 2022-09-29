%%Section5.3 #9(c)
%% Inputs

a = 1;          % left endpoint
b = 2;          % right endpoint
h = 0.1;        % stepsize
N = (b-a)/h;    % the number of steps
alpha = 0;      % initial y value

f = @(t,y) 2 * y/t + t^2 * exp(t);        % as in dy/dt = f(t,y);
df = @(t) 2*exp(t)-2*exp(1)+4*exp(t)*t+exp(t)*t^2;
d2f = @(t) exp(t)*t^2+6*exp(t)*t+6*exp(t);
d3f = @(t) exp(t)*t^2+8*t*exp(t)+12*exp(t);

%% Order 4

t = zeros(1,N+1);
u = zeros(1,N+1);       % stores all the approximation values for order 4

t(1) = a;
u(1) = alpha;

for i=1:N
    u(i+1) = u(i) + h*f(t(i),u(i)) + (h^2/2)*df(t(i)) + (h^3/factorial(3))*d2f(t(i)) + (h^4/factorial(4))*d3f(t(i));
    t(i+1) = a + i*h;
end

y = @(t) t^2*(exp(t)-exp(1));
error_order_4 = zeros(1,N+1);
fprintf('i\tt_i\t\tu_i\t\ty(t_i)\t\t|y(t_i) - u(i)|\n')
for i=1:N+1
    error_order_4(i) = abs( y(t(i)) - u(i) ); 
    fprintf('%d\t%.9f\t%.9f\t%.9f\t%.9f\n',i,t(i),u(i),y(t(i)),error_order_4(i))
end
