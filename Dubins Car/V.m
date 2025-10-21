% Speed function V(x), x=(x_1, x_2)
function [V] = V(x)
    V = 1 + 0.9 * sin(5 * x(1)) * sin(5 * x(2));
end