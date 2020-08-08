% calculate the value of the l_1-regularized function 
% mu*||x||_1 + (1/2)*||Ax-b||_2^2
function y = l1(x,A,b,mu)
y = mu * norm(x,1) + 0.5 * norm(A * x - b,2)^2;
