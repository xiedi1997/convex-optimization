% calculate the value of the augmented lagrangian function
% L = -b'*lambda + 0.5*||lambda||^2 + x'(A'*lambda-s)+(1/(2*tau))*||A'lambda-s||^2
function y = DL_function(x, A, b, lambda, s, tau)
y = -b'*lambda + 0.5*(lambda'*lambda) + x'*(A'*lambda-s) + 1/(2*tau)*norm(A'*lambda-s,2)^2;