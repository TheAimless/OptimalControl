% Updates x^{k+1}_j based on eq. (16), Parkinson & Polage
function [x_next] = prox_x(x, eta, delta, tau, p, v, A, W, x_f, O, gradO)
% x_next = x - eta * (-delta * gradH(x, p, A, x_f, O, gradO) + (x - v) / tau);
    theta = x(3);
    w = p(1) * cos(theta) + p(2) * sin(theta);
    C = abs(w) + W * abs(p(3));
    gr = gradR(x, x_f, A);
    H_y = gr(1) * (C * O - 1) + r_xf(x, x_f, A) * C * gradO(1);
    H_z = gr(2) * (C * O - 1) + r_xf(x, x_f, A) * C * gradO(2);
    H_theta = gr(3) * (C * O - 1) + r_xf(x, x_f, A) * O * (p(2) * cos(theta)...
        - p(1) * sin(theta)) * w / (abs(w) + 1e-8);
    y_next = x(1) - eta * (-delta * tau * H_y + (x(1) - v(1)));
    z_next = x(2) - eta * (-delta * tau * H_z + (x(2) - v(2)));
    theta_next = x(3) - eta * (-delta * tau * H_theta + (x(3) - v(3)));
    x_next = [y_next, z_next, theta_next];
end