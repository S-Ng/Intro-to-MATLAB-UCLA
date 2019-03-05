% EULER-BERNOULLI BEAM BENDING
% Simon Ng
% UID: 304993160
% 22 May, 2018

% Clear MATLAB Workspace
clear all;
clc;

% Set Beam Characteristics
L = 1; % length (m)
R = 0.013; % outer radius (m)
r = 0.011; % inner radius (m)
P = 2000; % pressure (N)
d = 0.75; % location of applied pressure (m)
N = 20; % number of nodes
x = linspace(0, L, N); % location of nodes (m)
dx = x(2)-x(1); % distance between nodes

E = 70*10^9; % modulus of elasticity (N/m^2)
I = pi/4*(R^4 - r^4); % moment of inertia

% Construct A-matrix
A = zeros(N,N);
A(1,1) = 1; % left end of beam (top row)
A(N,N) = 1; % right end of beam (bottom row)
for k = 2:N-1 % inner rows of A
    A(k,k-1:k+1) = [1, -2, 1];
end

% Construct b-Matrix
b = zeros(N,1);
for j = 2:N-1 % inner rows of b
    
    % Calculate M(x)
    if x(j) >= 0 && x(j) <= d
        M(j) = -P*(L-d)*x(j)/L;
    elseif x(j) > d && x(j) <= L
        M(j) = -P*d*(L-x(j))/L;
    end
    
    % Construct b(x)
    b(j) = dx^2*M(j)/(E*I);
end
    % Set b Endpoints
    b(1) = 0;
    b(N) = 0;

% Calculate y (displacement at each node)
y = zeros(N,1);
y = -A\b;

% Calculate Error
c = min(d,L-d);
y_max_theoretical = (P*c*(L^2-c^2)^(3/2))/(9*sqrt(3)*E*I*L);
y_max_calculated = max(abs(y));
Percent_error = (y_max_calculated - y_max_theoretical)/y_max_theoretical*100;
fprintf('Percent Error: %f%%\n', Percent_error);

% Plot Deflection (y)
    % M(N) = 0; % M endpoint for graphing
    % Mmod = 0.000025*M; % scale M for visualization
figure
plot(x, y, 'o-')
xlabel('Distance Along Beam (m)');
ylabel('Vertical Displacement (m)');
title(sprintf('Beam Bending: Distance of Force = %.2f m', d));
