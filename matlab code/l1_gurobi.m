% use the gurobi to solve following l_1-regularized problem
% min mu*||x||_1 + (1/2)*||Ax-b||_2^2
% x0 is a given input initial solution(It is not used in this function)
% opts is a struct which stores the options of the algorithm(It is not used in this function)
% x is the optimal solution
% out is a struct which saves all other output information.

function [x, out] = l1_gurobi(x0, A, b, mu, opts)

m = size(A, 1);
n = size(A, 2);

% Set objective : (x^T)*Q*x + (c^T) * x
model . Q = sparse([zeros(n,n),zeros(n,m),zeros(n,n);zeros(m,n),0.5*eye(m,m),zeros(m,n);zeros(n,n),zeros(n,m),zeros(n,n)]);
model . obj = [zeros(1,n), zeros(1,m), mu*ones(1,n)];  % c
model . lb = -inf * ones(1, n + m + n);  % Lower bound of x
model . ub = inf * ones(1, n + m + n); % upper bound of x
model . modelsense = 'min';  % minimize the objective function

% Add constraint : Ax = b; Gx <= h
model .A = sparse([A, -eye(m,m), zeros(m,n);eye(n,n), zeros(n,m), -eye(n,n);eye(n,n), zeros(n,m), eye(n,n)]);
model .rhs = [b', zeros(1,n), zeros(1,n)];
model . sense = [repmat('=',1,m),repmat('<',1,n),repmat('>',1,n)];

% solve the problem
gurobi_write (model , 'qp .lp');



out = gurobi ( model );
x = out.x(1:n);
