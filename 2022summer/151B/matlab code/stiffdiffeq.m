% Author: Ryan Arbon
% Date: August 23, 2022
% Program: Demonstrates aspects of stiff ODEs
%% The relevant functions and problem parameters to set up the IVP

% Function defining the ODE y' = f(t,y)
f = @(t,x) -30.*x;
g = @(t,x) -2 * t .* x.^2;
F = @(t) exp(-30.*t);
Fc = @(t,c) c.*exp(-30.*t);
G = @(t) 1./(t.^2+1);
Gc = @(t,c) 1./(t.^2+c);


t_start = 0;                    % Initial time
t_end = 1;                      % Final time
y_start = 1;                   % Initial value of y

h = 0.1;

[w1, t1, N] = euler(t_start, t_end, y_start, 0.07, f);
[w2, t2, N] = euler(t_start, t_end, y_start, 0.06, f);
ts = linspace(t_start,t_end,200);

plot(ts,F(ts), 'b');
hold on;
plot(ts,Fc(ts,100),'g')
plot(ts,Fc(ts,100),'g')
plot(ts,Fc(ts,1000),'g')
plot(ts,Fc(ts,-1000),'g')
plot(ts,Fc(ts,5000),'g')
plot(ts,Fc(ts,-5000),'g')
%plot(t1,w1,'*-')
%plot(t2,w2,'*-')
xlim([t_start t_end]);
ylim([-1 1]);
hold off;





% t_end = 4;
% ts = linspace(t_start,t_end,200);
% tz = linspace(1.5,t_end,200);
% [w, t, N] = cdm(t_start, t_end, y_start, G(t_start+h), h, g);
% hold on;
% plot(ts,Gc(ts,1),'b',ts,Gc(ts,0.2), 'g',ts,Gc(ts,1.8), 'g',ts,Gc(ts,8), 'g',tz,Gc(tz,-2), 'g');
% xlim([t_start t_end]);
% ylim([0 1]);
% plot(t,w, '*-');
% hold off;




%% The function implementing the central difference method
function [w, t, N] = cdm(t_start, t_end, y_start, y_start2, h, f)
    
    % Number of timesteps to take. Note that we need to cast
    % N to be an integer type.
    
    N = int16((t_end - t_start)/h); 
    t = zeros(N+1,1);           % Initialize arrays
    w = zeros(N+1,1);
    
    t(1) = t_start;             % Initial conditions
    t(2) = t_start + h;
    w(1) = y_start;
    w(2) = y_start2;
    
    for i = 2:(N)               % Begin looping
        t(i+1) = t(i) + h;
        w(i+1) = w(i-1) + 2*h*f(t(i),w(i));
    end
end

function [w, t, N] = euler(t_start, t_end, y_start, h, f)
    
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