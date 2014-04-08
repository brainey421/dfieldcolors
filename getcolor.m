function [r, g, b] = getcolor(mag, mag_min, mag_max)

% getcolor(mag, mag_min, mag_max)
% 
% Finds the color for a vector on the colored direction field.

% val is a number between 0 and 1, where
% 0 is blue and 1 is red
val = (mag - mag_min) / (mag_max - mag_min);

if val < 0.25
    r = 0;
    g = 4 * val;
    b = 1;
elseif val < 0.5
    r = 0;
    g = 1;
    b = 1 - 4 * (val - 0.25);
elseif val < 0.75
    r = 4 * (val - 0.5);
    g = 1;
    b = 0;
else
    r = 1;
    g = 1 - 4 * (val - 0.75);
    b = 0;
end