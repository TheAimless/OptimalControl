% Updates x^{k+1}_j based on eq. (16), Parkinson & Polage
function [x_next] = prox_x(x, eta, delta, tau, p, v, A, x_f, O, gradO)
    x_next = x - eta * (-delta * gradH(x, p, A, x_f, O, gradO) + (x - v) / tau);
end
% Wrong Hamiltonian, change this part