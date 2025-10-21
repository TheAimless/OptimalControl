% Gradient of the Hamiltonian
function [gradH] = gradH(x, p, A, x_f, O, gradO)
    %gradH = norm(p) * (gradR(x, x_f, A) * V(x) * Ox ...
    %    + r_xf(x, x_f, A) * gOx * V(x) ...
    %    + r_xf(x, x_f, A) * Ox * gradV(x)) - gradR(x, x_f, A);

    %gradH = norm(p) * (gradR(x, x_f, A) * V(x) + gradV(x) * r_xf(x, x_f, A)) - gradR(x, x_f, A);

    gradH = r_xf(x, x_f, A) * norm(p) * (O * gradV(x) + V(x) * gradO) + ...
        (norm(p) * O * V(x) - 1) * gradR(x, x_f, A);
end