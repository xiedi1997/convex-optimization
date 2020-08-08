% use the projection gradient method to solve following l_1-regularized problem
% min mu*||x||_1 + (1/2)*||Ax-b||_2^2
% x0 is a given input initial solution
% opts is a struct which stores the options of the algorithm
% x is the optimal solution
% iter is the total number of iterations
% out is a struct which saves all other output information.
function [x, iter, out] = l1_PGD_primal(x0, A, b, mu, opts)

% initial
n = size(A, 2);    % number of decision variable
Max = 200;    % maximum of each iteration in mu
eps = 1e-9;    % termination of the precision
t = 0.00045;

y0 = max(x0, 0);
z0 = -min(x0,0);

f1 = l1(x0,A,b,mu);
k = 0;    % the number of total iterations

% projection gradient iteration
for j = 5:-1:0
    kk = 1;    % the number of iterations per loop
    k = k + 1;
    f0 = f1;
    g = A' * (A * x0 - b);
    g = [g; -g] + 10^j*mu * ones(2 * n, 1);    % gradient
    X0 = max([y0;z0] - t * g, 0);
    y0 = X0(1:n);
    z0 = X0(n+1:2*n);
    x0 = y0 -z0;
    f1 = l1(x0,A,b,mu);
    f(k) = f1;
    % f1-f0
    while abs(f1-f0) > eps
        if kk < Max
            kk = kk + 1;
            k = k + 1;
            f0 = f1;
            g = A' * (A * x0 - b);
            g = [g; -g] + 10^j*mu * ones(2 * n, 1);
            X0 = max([y0;z0] - t * g, 0);
            y0 = X0(1:n);
            z0 = X0(n+1:2*n);
            x0 = y0 -z0;
            f1 = l1(x0,A,b,mu);
            f(k) = f1;
            %     f1-f0
        else
            break;
        end
    end
end

x = x0;
out.objvalue = f1;
out.y = f;
iter = k;