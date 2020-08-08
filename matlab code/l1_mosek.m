% use the mosek to solve following l_1-regularized problem
% min mu*||x||_1 + (1/2)*||Ax-b||_2^2
% x0 is a given input initial solution(It is not used in this function)
% opts is a struct which stores the options of the algorithm(It is not used in this function)
% x is the optimal solution
% out is a struct which saves all other output information.

function [x, out] = l1_mosek(x0, A, b, mu, opts)

clear prob;

m = size(A, 1);
n = size(A, 2);


[r, res] = mosekopt('symbcon');

% Set objective : (c^T) * x
prob.c   = [zeros(1, n), zeros(1, m), mu*ones(1, n), 0.5, zeros(1, m), 0, 0]; % c
prob.blx = [-inf * ones(1, n + m + n), 0, -inf * ones(1, m), -inf, -inf]; % Lower bound of x
prob.bux = inf*ones(1, n + m + n + 1 + m + 1 + 1); % upper bound of x

% Add constraint : b <= Ax <= b
prob.a   = sparse([A, -eye(m), zeros(m, n), zeros(m, 1), zeros(m, m), zeros(m, 1), zeros(m, 1); 
                   -eye(n), zeros(n, m), eye(n), zeros(n, 1), zeros(n, m), zeros(n, 1), zeros(n, 1);
                   eye(n), zeros(n, m), eye(n), zeros(n, 1), zeros(n, m), zeros(n, 1), zeros(n, 1);
                   zeros(m, n), -2*eye(m), zeros(m, n), zeros(m, 1), eye(m), zeros(m,1), zeros(m, 1);
                   zeros(1, n), zeros(1, m), zeros(1, n), -1, zeros(1, m), 1, 0;
                   zeros(1, n), zeros(1, m), zeros(1, n), -1, zeros(1, m), 0, 1]); 
prob.blc = [b', zeros(1, n), zeros(1, n), zeros(1, m), -1, 1]; % Lower bound
prob.buc = [b', inf*ones(1,n), inf*ones(1,n), zeros(1, m), -1, 1]; % upper bound

% Add second - order cone : 
prob.cones.type   = res.symbcon.MSK_CT_QUAD;
list = zeros(1, m + 2);
list(1) = 2*m + 2*n + 3;
for i = 2:m+2
    list(i) = 2*n + m + i;
end
prob.cones.sub = list;
prob.cones.subptr = 1;

% % solve the problem
[r,out]=mosekopt('minimize',prob);
x = out.sol.itr.xx(1:n);
