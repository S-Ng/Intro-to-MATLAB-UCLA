% SPLIT AND AVERAGE
% Simon Ng
% UID: 304993160

% Clear MATLAB Workspace
clear all;
clc;

% Solicit Number of Vertices
nVertices = input('Please enter the number of vertices: ');

% Initialize Size of X and Y Coordinate Arrays
x = zeros(1, nVertices);
y = zeros(1, nVertices);

% Solicit X and Y Vertex Coordinates
for k = 1:nVertices
    fprintf('Please enter the coordinates for point %i\n', k);
    x(k) = input('x: ');
    y(k) = input('y: ');
end

% Initialize Weight Array
w = zeros(1, 3);

% Solicit Weights
fprintf('Please enter the weight for the following:');
w(1) = input('\nLeft point: ');
w(2) = input('Original point: ');
w(3) = input('Right point: ');

% % Test Arrays
%  x = [0 0 1 1];
%  y = [0 1 1 0];
%  w = [1 2 1];

count = 0;
xOld = x;
yOld = y;
ds_max = 1;

% Iterate Until Shape Change is Small
while ds_max >= 1*10^-3 && count <= 30
    
    % Count Number of Iterations
    count = count+1;
    
    % Set Size of Arrays
    lengthArrays = 2*length(xOld);
    xSplit = zeros(1, lengthArrays);
    ySplit = zeros(1, lengthArrays);
    xAvg = zeros(1, lengthArrays);
    yAvg = zeros(1, lengthArrays);
    
    % Calculate Split and Average
    xSplit = splitPts(xOld);
    ySplit = splitPts(yOld);
    xAvg = averagePts(xSplit, w);
    yAvg = averagePts(ySplit, w);
    
    % Calculate Change in Node Location
    dx = xAvg - xSplit;
    dy = yAvg - ySplit;
    ds = sqrt(dx.^2+dy.^2);
    ds_max = max(ds);
    
    % Reset Arrays for Next Iteration
    xOld = xAvg;
    yOld = yAvg;
    
end

% Make New Arrays to Connect Last and First Point
xaPlot = zeros(1, length(xOld)+1);
yaPlot = zeros(1, length(yOld)+1);
xaPlot = [xOld, xOld(1)];
yaPlot = [yOld, yOld(1)];

% Plot Inital Points and Final Connected Points
figure
plot(x, y, '.', xaPlot, yaPlot)
axis([min(x)-0.5 max(x)+0.5 min(y)-0.5 max(y)+0.5])
axis square

fprintf('\nNumber Iterations: %i\n', count);
