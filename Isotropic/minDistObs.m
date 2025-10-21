function [D, m] = minDistObs(x, xC, r)
    [D, m] = min(sqrt((x(1) - xC(:, 1)).^2 ...
              + (x(2) - xC(:, 2)).^2) - r);
end