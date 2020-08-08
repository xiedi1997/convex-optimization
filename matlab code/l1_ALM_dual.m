% use the ALM to solve following l_1-regularized dual problem
% min mu*||x||_1 + (1/2)*||Ax-b||_2^2
% x0 is a given input initial solution
% opts is a struct which stores the options of the algorithm
% x is the optimal solution
% iter is the number of iterations
% out is a struct which saves all other output information.

function [x, iter, out] = l1_ALM_dual(x0, A, b, mu, opts)

% initial
tau = 1e2;    % number of lagrange penalty term
Max = 150;    % maximum of each iteration in mu
eps = 1e-9;    % termination of the precision
eps1 = 1e-3;    % termination of the precision of DL subproblem

% Values that need to be used repeatedly
A1 = (A*A' + tau*eye(512))^(-1); 
b1 = tau*b;

% initialize variable randomly that can be reproducted
rng(0);
lambda = rand(512, 1);
s = rand(1024, 1);

f1 = l1(x0, A, b, mu);
k = 0;    % the number of total iterations

% ALM iteration
for j = 3:-1:0
    kk = 1;    % the number of iterations per loop
    k = k + 1;
    f0 = f1;
    [lambda, s] = l1_ALM_dual_DL(x0, A, b, 10^j*mu, lambda, s, tau, A1, b1, eps1); % solve the DL subproblem
    x0 = x0 + (A'*lambda - s) / tau;
    f1 = l1(x0, A, b, mu);
    f(k) = f1;
    % f1-f0
    while  abs(f0 - f1) > eps
        if kk < Max
            kk = kk + 1;
            k = k + 1;
            f0 = f1;
            [lambda, s] = l1_ALM_dual_DL(x0, A, b, 10^j*mu, lambda, s, tau, A1, b1, eps1); % solve the DL subproblem
            x0 = x0 + (A'*lambda - s) / tau;
            f1 = l1(x0, A, b, mu);
            f(k) = f1;
            % f1-f0
        else
            break;
        end
    end
end
x = x0;
iter = k;
out.objvalue = l1(x0, A, b, mu);
out.y = f;
