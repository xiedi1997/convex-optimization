% function Test_l1_regularized_problems

% min 0.5 ||Ax-b||_2^2 + mu*||x||_1

% generate data

seed = 97006855;
fprintf('rand seed = %d;\n', seed);
ss = RandStream ( 'mt19937ar', 'Seed', seed);
RandStream.setGlobalStream(ss);

n = 1024;
m = 512;

clear A u b;
A = randn(m, n);
u = sprandn(n, 1, 0.1);
b = A*u;
mu = 1e-3;
x0 = rand(n,1);

errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));

% cvx calling mosek
opts_mosek = [];
tic; 
[x_mosek, out_mosek] = l1_cvx_mosek(x0, A, b, mu, opts_mosek);
t_mosek = toc;

% other approaches

% projection gradient method
opts1 = [];
tic;
[x1 , iter1, out1] =l1_PGD_primal(x0, A, b, mu, opts1);
t1 = toc;

% subgradient method
opts2 = [];
tic;
[x2, iter2, out2] = l1_SGD_primal(x0, A, b, mu, opts2);
t2 = toc;

% proximal gradient method
opts3 = [];
tic;
[x3, iter3, out3] = l1_ProxGD_primal(x0, A, b, mu, opts3);
t3 = toc;

% ALM for dual problem
opts4 = [];
tic;
[x4, iter4, out4] = l1_ALM_dual(x0, A, b, mu, opts4);
t4 = toc;

% ADMM for dual problem
opts5 = [];
tic;
[x5, iter5, out5] = l1_ADMM_dual(x0, A, b, mu, opts5);
t5 = toc;

% ADMM for primal problem
opts6 = [];
tic;
[x6, iter6, out6] = l1_ADMM_lprimal(x0, A, b, mu, opts6);
t6 = toc;

% compare in objective value,error,time,iterator,sparsity and degree of recovery 
% objective value
objval_mosek = out_mosek.optval;
objval1 = out1.objvalue;
objval2 = out2.objvalue;
objval3 = out3.objvalue;
objval4 = out4.objvalue;
objval5 = out5.objvalue;
objval6 = out6.objvalue;

% error
error_mosek = errfun(x_mosek, x_mosek);
error1 = errfun(x_mosek, x1);
error2 = errfun(x_mosek, x2);
error3 = errfun(x_mosek, x3);
error4 = errfun(x_mosek, x4);
error5 = errfun(x_mosek, x5);
error6 = errfun(x_mosek, x6);

% sparsity
sparsity_mosek = norm(x_mosek, 1);
sparsity1 = norm(x1, 1);
sparsity2 = norm(x2, 1);
sparsity3 = norm(x3, 1);
sparsity4 = norm(x4, 1);
sparsity5 = norm(x5, 1);
sparsity6 = norm(x6, 1);

% degree of recovery 
recovery_mosek = norm(A * x_mosek - b, 2);
recovery1 = norm(A * x1 - b, 2);
recovery2 = norm(A * x2 - b, 2);
recovery3 = norm(A * x3 - b, 2);
recovery4 = norm(A * x4 - b, 2);
recovery5 = norm(A * x5 - b, 2);
recovery6 = norm(A * x6 - b, 2);

fprintf(' cvx-call-mosek: objvalue: %3.4e, cpu: %5.2f, err-to-cvx-mosek: %3.2e, iterator: -----, sparsity: %3.4f, recovery: %3.4e\n', objval_mosek, t_mosek, error_mosek, sparsity_mosek, recovery_mosek);
fprintf('     projection: objvalue: %3.4e, cpu: %5.2f, err-to-cvx-mosek: %3.2e, iterator: %5.0f, sparsity: %3.4f, recovery: %3.4e\n', objval1, t1, error1, iter1, sparsity1, recovery1);
fprintf('    subgradient: objvalue: %3.4e, cpu: %5.2f, err-to-cvx-mosek: %3.2e, iterator: %5.0f, sparsity: %3.4f, recovery: %3.4e\n', objval2, t2, error2, iter2, sparsity2, recovery2);
fprintf('       proximal: objvalue: %3.4e, cpu: %5.2f, err-to-cvx-mosek: %3.2e, iterator: %5.0f, sparsity: %3.4f, recovery: %3.4e\n', objval3, t3, error3, iter3, sparsity3, recovery3);
fprintf('       ALM_dual: objvalue: %3.4e, cpu: %5.2f, err-to-cvx-mosek: %3.2e, iterator: %5.0f, sparsity: %3.4f, recovery: %3.4e\n', objval4, t4, error4, iter4, sparsity4, recovery4);
fprintf('      ADMM_dual: objvalue: %3.4e, cpu: %5.2f, err-to-cvx-mosek: %3.2e, iterator: %5.0f, sparsity: %3.4f, recovery: %3.4e\n', objval5, t5, error5, iter5, sparsity5, recovery5);
fprintf('    ADMM_primal: objvalue: %3.4e, cpu: %5.2f, err-to-cvx-mosek: %3.2e, iterator: %5.0f, sparsity: %3.4f, recovery: %3.4e\n', objval6, t6, error6, iter6, sparsity6, recovery6);