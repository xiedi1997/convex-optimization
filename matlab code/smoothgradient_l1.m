% calculate the gradient of the smoothed l_1-regularized function 
% mu*phi_mu1(x) + (1/2)*||Ax-b||_2^2
function y = smoothgradient_l1(x, A, b, mu)
n = 1024;
y = A' * (A * x - b);
mu1 = 1e-9;
for i = 1:n
    if x(i) <= -mu1
        y(i) = y(i) - mu;
    elseif x(i) >= mu1
        y(i) = y(i) + mu;
    else
        y(i) = y(i) + mu*x(i)/mu1;
    end
end