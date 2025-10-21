% Returns Hamiltonian

function [H] = H(x, p, x_f, A, O)
    H = r_xf(x, x_f, A) * (V(x) * O * norm(p) - 1);
end