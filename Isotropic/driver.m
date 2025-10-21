clear;
x_f = [4/5, -2/5]; x_start = [-3/5, 3/5]; % Final and starting position
t = 3; delta = .1; J = t / delta; % Time variables
sigma = 1; tau = .24; kappa = 1; eta = 0.2; % Hyperparams
eps = 1e-3; % Convergence
k_max = 30000; % Max iterations
A = 200; % Indicator approximation

% Obstacles
%r=[]; %[2 2 2 2] / 5;
%xC=[];%[-2 -2 3 3;
      %3 -1 3 -1] / 5;
r=[.2];
xC=[[0, 0.75]];
%r = [];
%xC = []; % Initialize obstacle center coordinates
%xC = [pi/2 + 0.2, pi/2 + 0.2;
%     -pi/2, pi/2;
%      pi/2, -pi/2]; % 3 x 2 matrix
%r = [0.8; 1; 1]; % 3 x 1 matrix

% Obstacle parameters
A_o = 100;
O = zeros(J + 1, 1);
gradO = zeros(J + 1, 2);

x = zeros(J + 1, 2); % Time step j and 2 spatial dimensions
for n = 1:J + 1
    x(n, :) = (1 - ((n - 1) / J)) * x_start + ((n - 1) / J) * x_f + 0.2 * randn(1, 2);
end
x(J + 1, :) = x_start;
x(1, :) = x_f;
p = zeros(J + 1, 2);
z = x;
u = 0;

for k = 1:k_max % Iterate
    % Update prev variables
    x_prev = x;
    p_prev = p;
    u_prev = u;

    for j = 2:J + 1      
        % Resolves obstacles
        if isempty(r)
            O(j) = 1;
            gradO(j, :) = [0, 0];
        else
            [D, m] = min(sqrt((x(j, 1) - xC(:, 1)).^2 + (x(j, 2) - xC(:, 2)).^2) - r);
            O(j) = 1/2 + (1/2) * tanh(A_o * D);
            gradO(j, :) = ((A_o / 2) * (sech(A_o * D)^2) / (D + r(m) + 1e-8)) * (x(j, :) - xC(m, :));
        end

        beta = p(j, :) + sigma * (z(j, :) - z(j - 1, :));
        p(j, :) = prox_p(delta * sigma * O(j), x, beta, x_f, A);
        % Peterson's
        %p(j, :) = max(0, 1 - (sigma * O(j) * delta * r_xf(x(j, :), x_f, A) * V(x(j, :))) / norm(beta, 2)) * beta;
    end
    
    x(1, :) = x_f; % g is infinity if x != x_f
    for j = 2:J
        v = x(j, :) - tau * (p(j, :) - p(j + 1, :));
        x(j, :) = prox_x(x(j, :), eta, delta, tau, p(j, :), v, A, x_f, O(j), gradO(j, :));
        %Peterson's
        %x(j, :) = x(j, :) - eta * (-delta * r_xf(x(j, :), x_f, A) * norm(p(j, :), 2) ...
        %    * (O(j) * gradV(x(j, :))+V(x(j, :)) * gradO(j, :)) ...
        %    + (norm(p(j, :), 2) * O(j) * V(x(j, :) - 1) * gradR(x(j, :), x_f, A)) ...
        %    + (1 / tau) * (x(j, :) - v));
    end

    for j = 1:J + 1
        z(j, :) = x(j, :) + kappa * (x(j, :) - x_prev(j, :));
    end

    % Use entry-wise norm
    change = max(max(max(abs(x - x_prev))), max(max(abs(p - p_prev))));
    if change < eps
        break;
    end

    u = 0;
    for j = 2:J+1
        u = u + dot(p(j, :), x(j, :) - x(j - 1, :))...
            - delta * H(x(j, :), p(j, :), x_f, A, O(j));
    end
    change_u = abs(u - u_prev);

    % print progress
    if mod(k,1000)==0
        fprintf('Iteration %i complete, change in (x,p) = %.4e, change in u = %.4e\n',k,change,change_u);
    end

    % halve the gradient descent rate each 1000 iterations after 5000
    if mod(k,1000)==0 && k >= 2000
        eta = eta / 2;
        % a = min(a+50,1000);
        % chi = @(x) 1 - exp(-a*norm(x-xf,2)^2);
        % chix = @(x) 2*a*(x-xf)*exp(-a*norm(x-xf,2)^2);
    end
end
u = 0;

for j = 2:J + 1
    u = u + dot(p(j, :), x(j, :) - x(j - 1, :))...
        - delta * H(x(j, :), p(j, :), x_f, A, O(j));
end
u % Final cost
plotV;