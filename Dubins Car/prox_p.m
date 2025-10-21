% Calculates prox_{\lambda H(x, \cdot, t)}(p)
function [p_star] = prox_p(lambda, x, p, x_f, A, W)
    theta = x(3); C = lambda * r_xf(x, x_f, A);
    w = p(1) * cos(theta) + p(2) * sin(theta);
    p_star = [(max(0, 1 - C / abs(w)) - 1) * w...
        * [cos(theta), sin(theta)] + p(1:2), max(0, 1 - C * W / abs(p(3))) * p(3)];
end