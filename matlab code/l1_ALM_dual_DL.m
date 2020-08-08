% solve the DL subproblem of the l_1-regularized dual problem
% min_(lambda,s)  -b^T*lambda+0.5*||lambda||^2+x^T(A^T*lambda-s)+(1/2mu)||A^T*lambda-s||^2
function [lambda, s] = l1_ALM_dual_DL(x0, A, b, mu, lambda, s, tau, A1, b1, eps)

k = 0;    % the number of iterations
Max = 10;    % max iterations 

f1 = DL_function(x0, A, b, lambda, s, tau);

f0 = f1;
lambda = A1*(A*(s - tau*x0) + b1);
s = DL_proj_s(A'*lambda + tau*x0, mu);
f1 = DL_function(x0, A, b, lambda, s, tau);
k = k + 1;
while abs(f1 - f0) > eps
    if k < Max
        f0 = f1;
        lambda = A1*(A*(s - tau*x0) + b1);
        s = DL_proj_s(A'*lambda + tau*x0, mu);
        f1 = DL_function(x0, A, b, lambda, s, tau);
        k = k + 1;
    else
        break;
    end
end