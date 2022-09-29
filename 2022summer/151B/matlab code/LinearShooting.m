%% Linear Shooting

%% Input information

a = 1;      % left endpoint
b = 2;      % right endpoint
alpha = 1;  % boundary condition at left endpoint
beta = 2;   % boundary condition at right endpoint
N = 10;     % number of subintervals

p = @(x) -2/x;
q = @(x) 2/x^2;
r = @(x) sin(log(x))/x^2;

%% Do the method

h = (b-a)/N;        % stepsize
u(1,1) = alpha;
u(2,1) = 0;
v(1,1) = 0;
v(2,1) = 1;

fprintf('x \t\t u1 \t\t v2 \n')
fprintf('%f \t %f \t %f\n',h,u(1,1),v(1,1))

% there might be an error somewhere in this loop, u and v do not match the
% textbook example

for i=1:N
    x = a + i*h;

    k11 = h * u(2,i);
    k12 = h * ( p(x) * u(2,i) + q(x) * u(1,i) + r(x) );
    k21 = h * ( u(2,i) + k12/2 );
    k22 = h * ( p(x + h/2) * ( u(2,i) + k12/2 ) + q(x + h/2) * ( u(1,i) + k11/2 ) + r(x + h/2) );
    k31 = h * ( u(2,i) + k22/2 );
    k32 = h * ( p(x + h/2) * ( u(2,i) + k22/2 ) + q(x + h/2) * ( u(1,i) + k21/2 ) + r(x + h/2) );
    k41 = h * ( u(2,i) + k32 );
    k42 = h * ( p(x + h) * ( u(2,i) + k32 ) + q(x + h)*( u(1,i) + k31 ) + r(x + h) );

    u(1,i+1) = u(1,i) + ( k11 + 2*k21 + 2*k31 + k41 )/6;
    u(2,i+1) = u(2,i) + ( k12 + 2*k22 + 2*k32 + k42 )/6;

    k_prime11 = h * v(2,i);
    k_prime12 = h * ( p(x) * v(2,i) + q(x) * v(1,i) );
    k_prime21 = h * ( v(2,i) + k_prime12/2 );
    k_prime22 = h * ( p(x + h/2) * ( v(2,i) + k_prime12/2 ) + q(x + h/2) * ( v(1,i) + k_prime11/2 ) );
    k_prime31 = h * ( v(2,i) + k_prime22/2 );
    k_prime32 = h * ( p(x + h/2) * ( v(2,i) + k_prime22/2 ) + q(x + h/2) * ( v(1,i) + k_prime21/2 ) );
    k_prime41 = h * ( v(2,i) + k_prime32 );
    k_prime42 = h * ( p(x + h) * ( v(2,i) + k_prime32 ) + q(x + h)*( v(1,i) + k_prime31) );

    v(1,i+1) = v(1,i) + (k_prime11 + 2*k_prime21 + 2*k_prime31 + k_prime41)/6;
    v(2,i+1) = v(2,i) + (k_prime12 + 2*k_prime22 + 2*k_prime32 + k_prime42)/6;
    
    fprintf('%f \t %f \t %f\n',x,u(1,i+1),v(1,i+1))
end

fprintf('\n')

w(1,1) = alpha;
w(2,1) = (beta - u(1,N+1))/(v(1,N+1));

fprintf('x \t\t w1 \t\t w2 \n')
%fprintf('%f \t %f \t %f\n',,w(1,1),w(2,1))

for i=1:N
    W1 = u(1,i+1) + w(2,1)*v(1,i+1);
    W2 = u(2,i+1) + w(2,1)*v(2,i+1);
    x = a + i*h;
    fprintf('%f \t %f \t %f\n',x,W1,W2)
end





