% NEWTON'S METHOD: ROOT FINDER
% Simon Ng
% UID: 304993160
% 26 May, 2018

clear all; clc;

% Set Function as Handle
n = 3; % function order (maximum expected number of real roots)
f = @(x) 816*x.^3 - 3835*x.^2 + 6000*x - 3125;
    % derivative of f: f = @(x) 816*3*x^2 -  3835*2*x +6000;

% Initialize Variables
delta = 1*10^-6; % how close y must be to 0 to count as a root
fEvalMax = 20; % max number of evaluations
N = 29; % number of iterations
xmin = 1.43; % min x initial guess for Newton's Method
xmax = 1.71; % max x inital guess for Newton's Method
dx = 0.01; % x step size
x = zeros(N, 1);
y = zeros(N, 1);
allroots = zeros(N, 1);
root = zeros(n, 1);
count = 0;

% Iterate Through Range of Points
for x0 = xmin:dx:xmax
    count = count + 1;
    [xc, fEvals] = Newton(f, x0, delta, fEvalMax); % run Newton's Method
    fprintf('x0 = %4.2f, evals = %2i, xc = %.6f\n', x0, fEvals, xc);
    NumEvals(count) = fEvals; % store number of evaluations
    allroots(count) = xc; % store all calculated roots
    x(count) = x0; % fill x array for graphing
    y(count) = f(x0); % fill y array for graphing
end

% Find Unique Roots
allroots = round(allroots, 6); % round root approximations to 6 decimals
root = unique(allroots, 'rows'); % find distinct roots
L = length(root); % number of roots
for k = 1:L
    fprintf('Root %i: %.6f\n', k, root(k));
end
zero = zeros(L, 1); % set y=0 for plotting each root
AvgNumEvals = mean(NumEvals); % average number of evaluations

% Plot Function
figure
plot(x, y, '.-', root, zero, 'ro');
grid on
