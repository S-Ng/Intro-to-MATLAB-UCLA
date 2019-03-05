% THE GAME OF LIFE
% Simon Ng
% UID: 304993160
% 22 May, 2018

% Clear MATLAB Workspace
clear all;
clc;

% Set Array Size
num_rows = 150; % number of rows
num_cols = 200; % number of columns
Gen = 300; % number of generations
Petri = zeros(num_rows, num_cols);
Petri2 = zeros(num_rows, num_cols);

% Set and Display Initial Distribution of Living vs Dead Cells
for k = 1:num_rows
    for j = 1:num_cols
        n = rand;
        if n >= 0.9
            Petri(k, j) = 1;
        else
            Petri(k, j) = 0;
        end
    end
end
figure
imagesc(Petri);
title(sprintf('Game of Life Simulation: Generation 1 of %3.0f', Gen))
pause(1) % wait 1 second

Population = zeros(1, Gen);
Population(1) = sum(sum(Petri)); % initial population size
Generation = linspace(1, Gen, Gen); % vector to count generations

figure
% Change Petri Dish Over Generations
for g = 2:Gen
    for r = 1:num_rows
        for c = 1:num_cols
            
            % Set Neighbors
            N = r - 1; % above
            S = r + 1; % below
            W = c - 1; % left
            E = c + 1; % right
            
            % Connect Boundaries
            if r == 1 % top boundary
                N = num_rows;
            elseif r == num_rows % bottom boundary
                S = 1;
            end
            if c == 1 % left boundary
                W = num_cols;
            elseif c == num_cols %  right boundary
                E = 1;
            end
            
            % Sum Neighbors
            Neighbors = Petri(N, W) + Petri(N, c) + Petri(N, E) + Petri(r, W) + Petri(r, E) + Petri(S, W) + Petri(S, c) + Petri(S, E);
            
            % Apply Game of Life Rules for New Array
            if Petri(r, c) == 1
                
                if Neighbors == 2 || Neighbors == 3 % 2 or 3 living neighbors
                    Petri2(r, c) = 1; % live
                else
                    Petri2(r, c) = 0; % die
                end
                
            elseif Petri(r, c) == 0
                
                if Neighbors == 3 % 3 living neighbors
                    Petri2(r, c) = 1; % live
                end
                
            end
        end
    end
    
    % Set Old Petri Dish as New for next Iteration
    Petri = Petri2;
    Population(g) = sum(sum(Petri));
    
    % Plot New Composition
    
    drawnow
    imagesc(Petri)
    title(sprintf('Game of Life Simulation: Generation %i of %3.0f', g, Gen))
    if mod(g, 50) == 0 && g ~= 300
        figure % new figure every 50 generations
    end
    
end

% Plot Population Dynamics Over Generations
figure
plot(Generation, Population)
xlabel('Generation');
ylabel('Population of Living Cells');
title('Cell Population Dynamics');
