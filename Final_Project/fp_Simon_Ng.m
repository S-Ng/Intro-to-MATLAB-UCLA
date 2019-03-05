% SMOOTHED PARTICLE HYDRODYNAMICS
% Simon Ng
% UID: 304993160
% June 15, 2018

clear all; clc;

n = 400; % approximate number of particles

% Select Simulation
Part_pos_optn = 1;
% Dam break: 1
% Sinking dinghy: 2
% Closing walls: 3
[x, y, xmax, ymax, N, F_ext, h, PosSolid, Solid_V, Solid_F, Solid_rho] = SPH_version(Part_pos_optn, n);
fprintf('%4.f particles\n', N);
SaveMovie = true; % create a movie?
mixed_po = false; % use mixed rest density?

% Set Inital Conditions
po = 500; % rest density
m = po/N; % particle mass
k = 50; % stiffness constant
mu = 0.1; % viscosity coefficient
Beta = 0.75; % wall-collision damping
dt = 0.0005; % time step
t_final = 0.5; % total time

% Create Particle Data Structure
Ntot = N + length(PosSolid); % total length including fluid and solid particles
Part(1:Ntot) = struct('pos', [], 'V', [0, 0], 'F', [], 'rho', [], 'neigh', [], 'State', [1]);

for ID1 = 1:N % add x and y to structure
    Part(ID1).pos(1, 1) = x(ID1);
    Part(ID1).pos(1, 2) = y(ID1);
end

% Add Solid to Structure
xSolid = zeros(length(PosSolid), 1);
ySolid = zeros(length(PosSolid), 1);
for ID2 = N + 1:Ntot
    ID2_2 = ID2-N; % index for arrays from SPH_version
    Part(ID2).pos = [PosSolid(ID2_2, 1), PosSolid(ID2_2, 2)];
    xSolid(ID2_2) = Part(ID2).pos(1);
    ySolid(ID2_2) = Part(ID2).pos(2);
    Part(ID2).V = [Solid_V(ID2_2, 1), Solid_V(ID2_2, 2)];
    Part(ID2).F = [Solid_F(ID2_2, 1), Solid_F(ID2_2, 2)];
    Part(ID2).rho = Solid_rho(ID2_2);
    Part(ID2).State = 2; % solid state = 2
end

% Create Bins
numcols = floor(xmax/h); % set number of columns
numrows = floor(ymax/h); % set number of rows
dx = xmax/numcols; % set bin size, x
dy = ymax/numrows; % set bin size, y
numbins = numcols*numrows; % total number of bins
Bin(1:numbins) = struct('IDs', [], 'bin_neigh', []); % create bin structure

% Identify Neighboring Bins
for bn1 = 1:numbins % iterate through all bins
    Bin(bn1).bin_neigh = findNeighbors(numrows, numcols, bn1); % find neighbors
end

% Plot Initial Positions
figure
plot(x, y, '.', xSolid, ySolid, 'k.')
axis([0, xmax, 0, ymax]) % full axis
daspect([1 1 1]) % equal x:y ratio
set(gca,'XTickLabel',[]); % no x axis labels
set(gca,'YTickLabel',[]); % no y axis labels
grid on % show gridlines
xticks(0:dx:xmax) % show bin grid x
yticks(0:dy:ymax) % show bin grid y
figure % open new figure for movie

% Movie
if SaveMovie == true
    vid = VideoWriter('SPH_Dam_Break4', 'MPEG-4');
    vid.FrameRate = 30;
    vid.Quality = 100;
    open(vid);
end

h = h/2; % make h radius instead of diameter

% Iterate Through Time Steps
for time = 0:dt:t_final
    
    % Assign Each Particle to a Bin
    for ID3 = 1:Ntot % assign bin number to each particle
        if Part(ID3).pos(1) == 0 && Part(ID3).pos(2) == ymax % particle is in top left corner
            b = 1; % first bin
        elseif Part(ID3).pos(1) == 0 % particle is on left side
            b = ceil((ymax - Part(ID3).pos(2))/dy); % modify bin sorting
        elseif Part(ID3).pos(2) == ymax % particle is on top boundary
            b = (ceil(Part(ID3).pos(1)/dx)-1)*numrows + 1; % modify bin sorting
        else % particle is not at boundary
            b = (ceil(Part(ID3).pos(1)/dx)-1)*numrows + ceil((ymax - Part(ID3).pos(2))/dy);
        end
        
        % Add Particle to Bin IDs List
        if mod(b, 1) == 0 && b > 0 && b <= length(Bin) % if b will not produce error
            Bin(b).IDs = [Bin(b).IDs, ID3];
        else % if b is odd, reset particle to (0.1,0.1)
            Part(ID3).pos(1) = 0.1;
            Part(ID3).pos(2) = 0.1;
            b = (ceil(Part(ID3).pos(1)/dx)-1)*numrows + ceil((ymax - Part(ID3).pos(2))/dy);
            Bin(b).IDs = [Bin(b).IDs, ID3];
        end
    end
    
    % Identify Neighboring Particles
    for bn2 = 1:numbins % iterate through all bins
        
        for neigh_bin = [bn2, Bin(bn2).bin_neigh] % iterate through bin and neighboring bins
            
            for ID4 = Bin(bn2).IDs % iterate through particles within bin
                
                for ID5 = Bin(neigh_bin).IDs % iterate through particles in bin and neighboring bin
                    
                    distx1 = Part(ID4).pos(1) - Part(ID5).pos(1); % x distance
                    disty1 = Part(ID4).pos(2) - Part(ID5).pos(2); % y distance
                    dist1 = sqrt(distx1^2 + disty1^2); % distance between particles
                    if dist1 < h && ID4 ~= ID5 % if particles are close and are not the same particle
                        Part(ID4).neigh = [Part(ID4).neigh, ID5]; % add new particle to list of neighbors
                    end
                end
            end
        end
    end
    
    % Calculate Density
    for ID6 = 1:N
        sum_neigh_rho = 0;
        
        for ID7 = [Part(ID6).neigh] % iterate through neighbors
            distx2 = Part(ID6).pos(1) - Part(ID7).pos(1); % x distance
            disty2 = Part(ID6).pos(2) - Part(ID7).pos(2); % y distance
            dist2 = sqrt(distx2^2 + disty2^2); % distance between points
            sum_neigh_rho = sum_neigh_rho + ((h^2)-dist2^2)^3; % sum densities
        end
        % Calculate density
        Part(ID6).rho = 4*m/(pi*(h^2)) + 4*m/(pi*(h^8))*sum_neigh_rho;
    end
    
    % Calculate Force
    for ID8 = 1:N
        sum_Force = 0;
        
        % To Use Different Resting Densities in Same Simulation
        if mixed_po == true
            if ID8 > N/2
                po = 1000;
            else
                po = 500;
            end
        end
        
        for ID9 = [Part(ID8).neigh]
            distx3 = Part(ID8).pos(1) - Part(ID9).pos(1); % x distance
            disty3 = Part(ID8).pos(2) - Part(ID9).pos(2); % y distance
            dist3 = sqrt(distx3^2 + disty3^2); % distance between points
            q = dist3/h;
            FP = (15*k*(Part(ID8).rho + Part(ID9).rho - 2*po)*(1-q)/q)*[distx3, disty3]; % force due to pressure
            velx = Part(ID8).V(1) - Part(ID9).V(1); % x velocity
            vely = Part(ID8).V(2) - Part(ID9).V(2); % y velocity
            FV = (-40*mu)*[velx, vely]; % force due to viscosity
            sum_Force = sum_Force + (m/(pi*h^4*Part(ID9).rho)*(1-q))*(FP+FV);
        end
        % Calculate total force
        Part(ID8).F = F_ext*Part(ID8).rho + sum_Force;
    end
    
    % Update Particles
    for ID10 = 1:N
        % Update Velocity and Position
        Part(ID10).V = Part(ID10).V + dt*Part(ID10).F/Part(ID10).rho; % new velocity
        Part(ID10).pos = Part(ID10).pos + dt*Part(ID10).V; % new position
        
        % Reflect Particles Outside Bounds
        % Check x bounds
        if Part(ID10).pos(1) > xmax
            Part(ID10).pos(1) = 2*xmax - Part(ID10).pos(1);
            Part(ID10).V(1) = -Beta*Part(ID10).V(1);
        elseif Part(ID10).pos(1) < 0
            Part(ID10).pos(1) = -Part(ID10).pos(1);
            Part(ID10).V(1) = -Beta*Part(ID10).V(1);
        end
        % Check y bounds
        if Part(ID10).pos(2) > ymax
            Part(ID10).pos(2) = 2*ymax - Part(ID10).pos(2);
            Part(ID10).V(2) = -Beta*Part(ID10).V(2);
        elseif Part(ID10).pos(2) < 0
            Part(ID10).pos(2) = -Part(ID10).pos(2);
            Part(ID10).V(2) = -Beta*Part(ID10).V(2);
        end
        
        % Reflect Particles From Solid
        stopx = 0;
        stopy = 0;
        for ID11 = N+1:Ntot
            % Check x
            if stopx ~= 1
                if abs(Part(ID10).pos(2)-Part(ID11).pos(2)) < 0.01
                    stopx = 1;
                    Part(ID10).V(2) = -Part(ID10).V(2);
                elseif abs(Part(ID10).pos(2)-Part(ID11).pos(2)) > 0.01
                    stopx = 1;
                    Part(ID10).V(2) = -Part(ID10).V(2);
                end
            end
            % Check y
            if stopy ~= 1
                if abs(Part(ID10).pos(2)-Part(ID11).pos(2)) < 0.01
                    stopy = 1;
                    Part(ID10).V(2) = -Part(ID10).V(2);
                elseif abs(Part(ID10).pos(2)-Part(ID11).pos(2)) > 0.01
                    stopy = 1;
                    Part(ID10).V(2) = -Part(ID10).V(2);
                end
            end
        end
        
        % Enter Fluid Structure Position Into x & y Arrays
        x(ID10) = Part(ID10).pos(1);
        y(ID10) = Part(ID10).pos(2);
        
        % Clear Particle Neighbor List
        Part(ID10).neigh = [];
    end
    
    % Update Solid
    for ID12 = 1:length(PosSolid)
        ID12_2 = ID12 + N;
        
        % Update Solid Position
        Part(ID12_2).pos(1) = Part(ID12_2).pos(1) + dt*Part(ID12_2).V(1);
        Part(ID12_2).pos(2) = Part(ID12_2).pos(2) + dt*Part(ID12_2).V(2);
        
        % Enter Solid Position Into x & y Arrays
        xSolid(ID12) = Part(ID12_2).pos(1);
        ySolid(ID12) = Part(ID12_2).pos(2);
    end
    
    % Clear Bin Particle List
    for bn3 = 1:numbins
        Bin(bn3).IDs = [];
    end
    
    % Plot Changing Positions
    drawnow
    plot(x, y, '.', xSolid, ySolid, 'k.')
    axis([0, xmax, 0, ymax]) % full axis
    daspect([1 1 1]) % equal x:y ratio
    set(gca,'XTickLabel',[]); % no x axis labels
    set(gca,'YTickLabel',[]); % no y axis labels
    if SaveMovie == true
        writeVideo(vid, getframe(gcf)); % add frame to movie
    end
end
if SaveMovie == true
    close(vid);
end
