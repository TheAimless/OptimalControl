% Calculates prox_{\lambda H(x, \cdot, t)}(p)
function [p_star] = prox_p(lambda, x, p, x_f, A)
    p_star = max(0, 1 - lambda * V(x) * r_xf(x, x_f, A) / norm(p, 2)) * p;
end