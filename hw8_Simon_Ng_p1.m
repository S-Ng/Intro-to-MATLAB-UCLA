% SPATIAL HASHING
% Simon Ng
% UID: 304993160
% May 29, 2018

clear all; clc;

% Solicit Parameters
    % N = input('Please enter the number of points: ');
    % xmax = input('Please enter the upper x bound: ');
    % ymax = input('Please enter the upper y bound: ');
    % h = input('Please enter the minimum cell dimension: ');

N = 50;
xmax = 1;
ymax = 1;
h = 0.25;

% Set X and Y
x = zeros(1, N);
y = zeros(1, N);

rng('default'); % set standard random seed
for i = 1:N % fill x and y
    x(i) = xmax*rand; % up to xmax
    y(i) = ymax*rand; % up to ymax
end

% Create Bins and Assign Particles
numcols = floor(xmax/h);
numrows = floor(ymax/h);
dx = xmax/numcols;
dy = ymax/numrows;

bin = zeros(1, N);
for j = 1:N % assign bin number to each particle
    if x(j) == 0 && y(j) == ymax % particle is in top left corner
        bin(j) = 1; % first bin
    elseif x(j) == 0 % particle is on left side
        bin(j) = ceil((ymax - y(j))/dy); % modify bin sorting
    elseif y(j) == ymax % particle is on top boundary
        bin(j) = (ceil(x(j)/dx)-1)*numrows + 1; % modify bin sorting
    else
        bin(j) = (ceil(x(j)/dx)-1)*numrows + ceil((ymax - y(j))/dy);
    end
end

% Find and Print Average Particle Location in Each Bin
numbins = numcols*numrows;
avgx = zeros(1, numbins);
avgy = zeros(1, numbins);

for b = 1:numbins % iterate through each bin
    count = 0;
    sumx = 0;
    sumy = 0;
    fprintf('Bin %2i:  ', b); % print bin label
    for k = 1:N % iterate through all points
        if bin(k) == b % if point is in bin being searched
            count = count + 1;
            sumx = sumx + x(k); % sum all x positions
            sumy = sumy + y(k); % sum all y positions
            fprintf('%i ', k); % print particle ID
        end
    end
    if count == 0 % if bin is empty
        fprintf('[]'); % print brackets
    end
    fprintf('\n'); % move to new line for next set of particle IDs
    avgx(b) = sumx/count; % average x location
    avgy(b) = sumy/count; % average y location
end

% Plot Particles and Average Locations
figure
plot(x, y, '.', avgx, avgy, 'o')
title(sprintf('%i Points Sorted Into Bins', N))
grid on % show gridlines
xticks(0:dx:xmax)
yticks(0:dy:ymax)
axis([0, xmax, 0, ymax]) % full axis
daspect([1 1 1]) % equal x:y ratio