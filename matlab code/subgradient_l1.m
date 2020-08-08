% calculate the subgradient of the l_1-regularized function 
% mu*||x||_1 + (1/2)*||Ax-b||_2^2
function y = subgradient_l1(x,A,b,mu)
n = 1024;
y = A'* (A * x - b);
for i = 1:n
    if x(i) < 0
        y(i) = y(i) - mu;
    elseif x(i) > 0
        y(i) = y(i) + mu;
    end
end
