% project s to the interval [-mu,mu]
function y = DL_proj_s(s, mu)
n = length(s);
y = s;
for i = 1:n
    if s(i) > mu
        y(i) = mu;
    elseif s(i) < -mu
        y(i) = -mu;
    end
end