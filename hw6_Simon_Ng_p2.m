% SIMULATED ANNEALING
% Simon Ng
% UID: 304993160

% Clear MATLAB Workspace
clear all;
clc;

% For a User-Input Number of Nodes, un-comment the code below
    % % Solicit Number of Nodes
    % N = input('Please enter the number of nodes: ');
    % if mod(N, 1) ~= 0
    %     error('Please enter an integer number of nodes.')
    % elseif N < 2
    %     error('Please enter at least 2 nodes.')
    % end

% Set Number of Nodes
N = 10;

% Set Node Positions
x = zeros(1, N);
y = zeros(1, N);
x = rand(1, N);
y = rand(1, N);

% Set Initial Path
path = zeros(1, N);
path = randperm(N);

% Calculate Length of Initial Path
dist_old = getPathDistance(x, y, path);

% Set Initial Temperature
T = 1000;

% Iterate Until T = 1
i = 1;
while T > 1
    % Store Distance in Storage Array for All Iterations
    dist_all(i) = dist_old;
    iteration(i) = i;
    
    % Swap 2 Points in Path
    swap_pts = randperm(N, 2);
    pathnew = path;
    pathnew(swap_pts(2)) = path(swap_pts(1));
    pathnew(swap_pts(1)) = path(swap_pts(2));
    
    % Calculate Length of New Path
    dist_new = getPathDistance(x, y, pathnew);
    
    % Calculate Change in Length
    deltaL = dist_new - dist_old;
    
    % Calculate Probability of Taking Unfavorable Route
    c = 1000;
    p = exp(-c*deltaL/T);
    
    % Determine Whether to Take New Path
    if deltaL < 0
        % Set New Path and New Distance
        path = pathnew;
        dist_old = dist_new;
    elseif p > rand
        % Set New Path and New Distance
        path = pathnew;
        dist_old = dist_new;
    end
    
    % Decrease Temperature
    T = 0.995*T;
    
    i = i+1;
end

% Set Vectors of Shortest Paths
for j = 1:N
    x_new(j) = x(path(j));
    y_new(j) = y(path(j));
end
x_new = [x_new, x_new(1)];
y_new = [y_new, y_new(1)];

% Plot Points and Shortest Distance Calculated
figure
plot(x_new, y_new, 'r o', x_new, y_new, 'b -');
xlabel('x-position');
ylabel('y-position');
title('Shortest Path Between Points');

% Plot Path Distance as a Function of Iteration Number
figure
plot(iteration, dist_all, 'b');
xlabel('Iteration Number');
ylabel('Path Distance');
title('Change in Path Distance Over Iterations');

fprintf('Shortest Distance = %f\n', dist_old);