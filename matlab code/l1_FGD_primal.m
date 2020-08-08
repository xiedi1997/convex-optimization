% use the fast smoothed gradient method to solve following l_1-regularized problem
% min mu*||x||_1 + (1/2)*||Ax-b||_2^2
% x0 is a given input initial solution
% opts is a struct which stores the options of the algorithm
% x is the optimal solution
% iter is the total number of iterations
% out is a struct which saves all other output information.
function [x, iter, out] = l1_FGD_primal(x0, A, b, mu, opts)

% initial
Max = 300;    % maximum of each iteration in mu
eps = 1e-10;    % termination of the precision
t = 0.0004;    % step size

k = 0;    % the number of total iterations
x1 = x0;
f1 = l1(x1,A,b,mu);

% fast smoothed gradient iteration
for j = 3:-1:0
    kk = 1;    % the number of iterations per loop
    k = k + 1;
    x0 = x1;
    y = x1 + (kk-2)/(kk+1)*(x1-x0);
    g = smoothgradient_l1(y,A,b,10^j * mu);
    x0 = x1;f0 = f1;
    x1 = y - t * g;
    f1 = l1(x1,A,b,mu);
    f(k) = f1;
    % f1-f0
    while abs(f1-f0) > eps
        if kk < Max
            kk = kk + 1;
            k = k + 1;
            y = x1 + (kk-2)/(kk+1)*(x1-x0);
            g = smoothgradient_l1(y,A,b,10^j*mu);
            x0 = x1; f0 = f1;
            x1 = y - t * g;
            f1 = l1(x1,A,b,mu);
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
