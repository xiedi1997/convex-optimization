% use the proximal gradient method to solve following l_1-regularized problem
% min mu*||x||_1 + (1/2)*||Ax-b||_2^2
% x0 is a given input initial solution
% opts is a struct which stores the options of the algorithm
% x is the optimal solution
% iter is the total number of iterations
% out is a struct which saves all other output information.
function [x, iter, out] = l1_ProxGD_primal(x0, A, b, mu, opts)

% initial
Max = 250;    % maximum of each iteration in mu
eps = 1e-9;    % termination of the precision
t = 0.0007;

f1 = l1(x0,A,b,mu);
k = 0;    % the number of total iterations

% proximal gradient iteration
for j = 4:-1:0
    kk = 1;    % the number of iterations per loop
    k = k + 1;
    f0 = f1;
    g = A'*(A * x0 - b);
    x0 = shrink(x0 - t * g, 10^j * mu * t);
    f1 = l1(x0,A,b,mu);
    f(k) = f1;
    % f1-f0
    while abs(f1-f0) > eps
        if kk < Max
            kk = kk + 1;
            k = k + 1;
            f0 = f1;
            g = A'*(A * x0 - b);
            x0 = shrink(x0 - t * g, 10^j * mu * t);
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
