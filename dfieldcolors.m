function dfieldcolors(f, g, bounds)

% dfieldcolors(f, g)
%
% Plots a color-coded direction field for an autonomous system of 
% two differential equations:
% 
% x'(t) = f(x, y)
% y'(t) = g(x, y)
% 
% This function plots the direction field for the intervals 
% bounds(1) < x < bounds(2) and bounds(3) < y < bounds(4).
% 
% Colors close to red indicate a relatively fast-moving solution, 
% and colors close to blue indicate a relatively slow-moving solution.
% 
% Example usage:
% 
% f = @(x, y)(-0.8*y);
% g = @(x, y)(0.2*x);
% dfieldcolors(f, g, [-5, 5, -5, 5]);

% Find the minimum and maximum magnitudes of vectors on the 
% direction field
mag_max = 0;
mag_min = Inf;
for ii=linspace(bounds(1), bounds(2), 17)
    for jj=linspace(bounds(3), bounds(4), 17)
        xprime = f(ii, jj);
        yprime = g(ii, jj);
        mag = norm([xprime, yprime]);
        
        if mag > mag_max
            mag_max = mag;
        end
        
        if mag < mag_min
            mag_min = mag;
        end
    end
end

% Plot each vector on the direction field
for ii=linspace(bounds(1), bounds(2), 17)
    for jj=linspace(bounds(3), bounds(4), 17)
        xprime = f(ii, jj);
        yprime = g(ii, jj);
        mag = norm([xprime, yprime]);
        
        [red, green, blue] = getcolor(mag, mag_min, mag_max);
        
        direction = [xprime; yprime];
        direction = direction / norm(direction);
        arrow1dir = [-0.7071, -0.7071; 0.7071, -0.7071] * direction;
        arrow2dir = [-0.7071, 0.7071; -0.7071, -0.7071] * direction;
        
        line(1) = (bounds(2) - bounds(1)) * direction(1) / 64;
        line(2) = (bounds(4) - bounds(3)) * direction(2) / 64;
        arrow1(1) = (bounds(2) - bounds(1)) * arrow1dir(1) / 128;
        arrow1(2) = (bounds(4) - bounds(3)) * arrow1dir(2) / 128;
        arrow2(1) = (bounds(2) - bounds(1)) * arrow2dir(1) / 128;
        arrow2(2) = (bounds(4) - bounds(3)) * arrow2dir(2) / 128;
        
        ha1 = plot([ii - line(1), ii + line(1)], ...
            [jj - line(2), jj + line(2)], ...
            'LineWidth', 2);
        hold on;
        ha2 = plot([ii + line(1), ii + line(1) + arrow1(1)], ...
            [jj + line(2), jj + line(2) + arrow1(2)], ...
            'LineWidth', 2);
        ha3 = plot([ii + line(1), ii + line(1) + arrow2(1)], ...
            [jj + line(2), jj + line(2) + arrow2(2)], ...
            'LineWidth', 2);
        
        set(ha1, 'color', [red, green, blue]);
        set(ha2, 'color', [red, green, blue]);
        set(ha3, 'color', [red, green, blue]);
    end
end

% Label the direction field
set(gca, 'FontSize', 16);
xlabel('x(t)');
ylabel('y(t)');
axis([bounds(1) - (bounds(2) - bounds(1)) / 16, ...
    bounds(2) + (bounds(2) - bounds(1)) / 16, ...
    bounds(3) - (bounds(4) - bounds(3)) / 16, ...
    bounds(4) + (bounds(4) - bounds(3)) / 16]);
hold off;