% NEIGHBOR IDENTIFICATION
% This script identifies the neighboring cells of a selected cell in a user-defined grid
% Simon Ng
% UID: 304993160

% CLEAN UP MATLAB WORKSPACE
clear all;
clc;

% REQUEST USER-INPUT ARRAY AND CELL

fprintf('NEIGHBORING CELL IDENTIFIER FOR A LINEARLY INDEXED GRID\n')
M = input('Please enter the number of rows: ');
N = input('Please enter the number of columns: ');
P = input('Please enter the cell number to analyze: ');

% TEST VALIDITY OF M,N, AND P

% Test that M and N are integers greater than or equal to 2      
if mod(M,1) ~= 0
    error('Please enter a whole number of rows.')
elseif mod(N,1) ~= 0
    error('Please enter a whole number of columns.')
elseif M < 2
    error('Please enter at least 2 rows.')
elseif N < 2
    error('Please enter at least 2 columns.')
end

% Test that P is an integer and between 1 and M*N
if mod(P,1) ~= 0
    error('Please enter an integer cell number.')
elseif P < 1 || P > M*N
    error('Please enter a cell number within the array.')
end

% IDENTIFY AND PRINT CELL NEIGHBORS

% Assign neighbor variables
a = P - M - 1;
b = P - M;
c = P - M + 1;
d = P - 1;
e = P + 1;
f = P + M - 1;
g = P + M;
h = P + M + 1;

% Classify location of P and its neighbors, and print
if P == 1
        % Top left corner
        fprintf('\nCell ID:   %d\n', P)
        fprintf('Neighbors: %d %d %d\n', e, g, h)
elseif P < M
        % Left wall
        fprintf('\nCell ID:   %d\n', P)
        fprintf('Neighbors: %d %d %d %d %d\n', d, e, f, g , h)
elseif P == M
        % Bottom left corner
        fprintf('\nCell ID:   %d\n', P)
        fprintf('Neighbors: %d %d %d\n', d, f, g)
elseif P == M*N - M + 1
        % Top right corner
        fprintf('\nCell ID:   %d\n', P)
        fprintf('Neighbors: %d %d %d\n', b, c, e)
elseif P == M*N
        % Bottom right corner
        fprintf('\nCell ID:   %d\n', P)
        fprintf('Neighbors: %d %d %d\n', a, b, d)
elseif P > M*N - M + 1
        % Right wall
        fprintf('\nCell ID:   %d\n', P)
        fprintf('Neighbors: %d %d %d %d %d\n', a, b, c, d, e)
elseif mod(P,M) == 1
        % Top wall
        fprintf('\nCell ID:   %d\n', P)
        fprintf('Neighbors: %d %d %d %d %d\n', b, c, e, g, h)
elseif mod(P,M) == 0
        % Bottom wall 
        fprintf('\nCell ID:   %d\n', P)
        fprintf('Neighbors: %d %d %d %d %d\n', a, b, d, f, g)
else
        % Middle
        fprintf('\nCell ID:   %d\n', P)
        fprintf('Neighbors: %d %d %d %d %d %d %d %d\n', a, b, c, d, e, f, g, h)
end
