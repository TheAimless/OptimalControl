% Approximation of indicator r_xf
function [r_xf] = r_xf(x, x_f, A)
    r_xf = 1 - exp(-A * norm(x - x_f, 2)^2);
end
