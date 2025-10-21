function [gradR] = gradR(x, x_f, A)
    gradR = 2 * A * (x - x_f) * exp(-A * norm(x - x_f, 2)^2);
end