% Compute the gradient of V
function [gradV] = gradV(x)
    gradV = 4.5 * [cos(5 * x(1)) .* sin(5 * x(2)), sin(5 * x(1)) .* cos(5 * x(2))];
end