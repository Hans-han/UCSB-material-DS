%%Section5.3 #9(a)
%% Inputs

a = 0;          % left endpoint
b = 1;          % right endpoint
h = 0.1;        % stepsize
N = (b-a)/h;    % the number of steps
alpha = 1;      % initial y value
f = @(t,y) (2-2*t*y)/(t^2+1);        % as in dy/dt = f(t,y);
df = @(t,y) (-8*t+6*t^2*y-2*y)/(t^2+1)^2;

%% Order 2

t = zeros(1,N+1);       % stores all the t values
w = zeros(1,N+1);       % stores all the approximation values for order 2

t(1) = a;
w(1) = alpha;
fprintf('i\t t\t\t w\t \n')

for i=1:N+1
    w(i+1) = w(i) + h*f(t(i),w(i)) + (h^2/2)*df(t(i),w(i));
    t(i+1) = a + i*h;
    fprintf('%d\t%.9f\t%.9f\n',i,t(i),w(i))

end