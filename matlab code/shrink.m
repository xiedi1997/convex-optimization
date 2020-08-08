% proximal operator of r(x) = y*|x|_1
% argmin(z)   y||z||_1 + (1/2)||z-x||_2^2
function z = shrink(x, y)
n = length(x);
z = zeros(n, 1);
for i = 1:n
    if x(i) > y
        z(i) = x(i) - y;
    end
    if x(i) < -y
        z(i) = x(i) + y;
    end
end 