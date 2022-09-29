% Author: Ryan Arbon
% Date: August 29, 2022
% Program: implements the linear fintie difference method for a degree two boundary
% value problem, solving 11.3.3(c)

%% Set up the problem parameters

% Defining functions for the first system
p = @(x) -(x+1);
q = @(x) 2;
r = @(x) (1-x^2)*exp(-x);

x_start = 0;
x_end = 1;
alpha = -1;
beta = 0;

h = 0.1;
N = int16((x_end - x_start)/h -1);






%% The function implementing the finite difference method

function [w,x] = findif(x_start,x_end, alpha, beta, f, N, h)


end

