%% Runge Kutta Fehlberg

% if you are having issues with the indices, you can replace t(i) -> t,
% t(i+1) -> t, w(i) -> w, w(i+1) -> w, etc.

%% Inputs

a = 0;              % left endpoint
b = 2;              % right endpoint
alpha = 0.5;        % initial y value
tol = 1e-5;         %tolerance
hmax = 0.25;        % maximum step size
hmin = 0.01;        % minimum step size

f = @(t,y) y - t^2 + 1;             % as in dy/dt = f(t,y);
y = @(t) (t+1)^2 - 0.5*exp(t);    % exact solution

%% Runge-Kutta-Fehlberg

t(1) = a;
w(1) = alpha;
h = hmax;
FLAG = 1;
N = (b-a)/hmin;
i = 1;
%j = 1;

fprintf('i \t t \t \t y_i = y(t_i) \t w_i \t\t h_i \t\t R \n')
fprintf('%d \t %f \t %f \t %f \n',0,t(1),y(t(1)),w(1))

while(FLAG == 1 && i < N+1) %% j < N+1?
    format long
    K1 = h * f(t(i), w(i));
    K2 = h * f(t(i) + h/4, w(i) + K1/4);
    K3 = h * f(t(i) + 3*h/8, w(i) + 3*K1/32 + 9*K2/32);
    K4 = h * f(t(i) + 12*h/13, w(i) + 1932*K1/2197 - 7200*K2/2197 + 7296*K3/2197);
    K5 = h * f(t(i) + h, w(i) + 439*K1/216 - 8*K2 + 3680*K3/513 - 845*K4/4104);
    K6 = h * f(t(i) + h/2, w(i) - 8*K1/27 + 2*K2 - 3544*K3/2565 + 1859*K4/4104 - 11*K5/40);

    R = (1/h)*abs( K1/360 - 128*K3/4275 - 2197*K4/75240 + K5/50 + 2*K6/55 );    % approximates the LTE

    if(R <= tol)
        t(i+1) = t(i) + h;
        w(i+1) = w(i) + 25*K1/216 + 1408*K3/2565 + 2197*K4/4104 - K5/5;
        %i = i+1; ???
        % move output stuff here?
    else
        disp("Ooops, might need to adjust the indices....");
    end

    % output stuff -- can move this inside the after line 45
    fprintf('%d \t %f \t %f \t %f \t %f \t %.9f \n',i,t(i+1),y(t(i+1)),w(i+1),h,R)
    
    % choose a new stepsize 
    delta = 0.84*(tol/R)^(1/4);
    if(delta <= 0.1)
        h = 0.1*h;
    else
        if(delta >= 4)
            h = 4*h;
        else
            h = delta*h;
        end
    end

    % check step size
    if(h > hmax)
        h = hmax;
    end

    if(t(i+1) >= b)
        FLAG = 0;
    else
        if(t(i+1) + h > b)
            h = b - t(i+1);
        else
            if(h < hmin)
                FLAG = 0;
                disp("Minimum h exceeded");
            end
        end
    end

    i = i + 1;
    %j = j+1;
end









