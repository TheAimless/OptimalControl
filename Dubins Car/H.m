% Returns Hamiltonian

function [H] = H(x, p, x_f, A, W, O)
    H = r_xf(x, x_f, A) * ((abs(p(1) * cos(x(3)) + p(2) * sin(x(3)))...
        + W * abs(p(3))) * O - 1);
end