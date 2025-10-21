% Calculates prox_{\lambda H(x, \cdot, t)}(p)
function [p_star] = prox_p(lambda, x, p, x_f)
    C = lambda * V(x);
    if x == x_f
        C = 0;
    end
    if norm(p) > C
       p_star = p - C * p / norm(p);
    else
        p_star = 0;
    end
end