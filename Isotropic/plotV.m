step = .05;
xx = -1.2:step:1.2;
yy = -1.2:step:1.2;

V_xy = @(xx, yy) 1 + 0.9 * sin(5 * xx) .* sin(5 * yy);

[X, Y] = ndgrid(xx, yy);
F = figure(2); clf; hold on;
Z = V_xy(X, Y);
contourf(X, Y, Z, 50, 'EdgeColor', 'none');
xp = x(:, 1);
yp = x(:, 2);
circX = cos(0:2*pi/100:2*pi);
circY = sin(0:2*pi/100:2*pi);
for m = 1:size(xC, 1)
    fill(xC(m, 1) + r(m) * circX, xC(m, 2) + r(m) * circY, [0.5,0,0], ...
        'edgecolor', 'none');
end
plot(xp, yp, 'k', 'LineWidth', 2);
xlabel('X-axis');
ylabel('Y-axis');
zlabel('V(x,y)');
title('Surface Plot of V(x,y)');