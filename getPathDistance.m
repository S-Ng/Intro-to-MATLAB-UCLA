function dist = getPathDistance(x, y, path)
% GETPATHDISTANCE is a function which calculates the length of a path given
% the x and y coordinates of each point and the order in which the
% coordinates are visited.

% Set Size of Array
ds = zeros(1, length(path));

% Find Distances Between Points
for k = 1:length(path)-1
    
    dx = x(path(k+1)) - x(path(k));
    dy = y(path(k+1)) - y(path(k));
    ds(k) = sqrt((dx)^2 + (dy)^2);
    
end

% Find Distance Between Last and First Point
dx = x(path(length(path))) - x(path(1));
dy = y(path(length(path))) - y(path(1));
ds(length(path)) = sqrt((dx)^2 + (dy)^2);

% Sum Distances
dist = sum(ds);
end