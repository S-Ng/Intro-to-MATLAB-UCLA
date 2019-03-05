function [x, y, xmax, ymax, N, F_ext, h, PosSolid, Solid_V, Solid_F, Solid_rho] = SPH_version(Part_pos_optn, n)

% SPH_VERSION is a function which contains 3 options for the intial
% setup of a smoothed particle dynamics model.
% It accepts 2 inputs, the option number and the number of particles.
% It outputs 11 variables, an x and y array of the inital fluid particle
% positions, the x and y bounds, the true number of particles, N, the external force, such as gravity, the
% bin size, h, and the position, velocity, and density of any solid
% particles within the simulation.
%
% Option 1: Regularly Arranged Dam Break Simulation
%
% Option 2: Sinking Dinghy - this simulation is not fully perfected
%
% Option 3: Closing Walls

% Produce Error if Option Number is Invalid
if mod(Part_pos_optn, 1) ~= 0
    error('The option number must be 1 through 3.');
elseif Part_pos_optn <= 0
    error('The option number must be 1 through 3.');
elseif Part_pos_optn > 3
    error('The option number must be 1 through 3.');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Regularly Arranged Dam Break Simulation
if Part_pos_optn == 1
    N = ceil(sqrt(n))^2; % actual number of particles
    xmax = 1; % x simulation bound
    ymax = 1; % y simulation bound
    xy_bound = 0.5; % x and y inital position bound
    step = xy_bound/sqrt(N); % distance between particles
    x = zeros(N, 1);
    y = zeros(N, 1);
    
    % Assign Fluid Positions
    ID1 = 0;
    for IDx = 1:ceil(sqrt(N))
        for IDy = 1:ceil(sqrt(N))
            ID1 = ID1 + 1;
            rx = rand;
            x(ID1) = IDx*step*(rx/(rx+0.001));
            ry = rand;
            y(ID1) = IDy*step*(ry/(ry+0.001));
        end
    end
    
    % Set h and F_ext
    h = sqrt(3*xy_bound/N);
    F_ext = [0, -98]; % gravitational force
    
    % No Solid Objects
    PosSolid = [];
    Solid_V = [];
    Solid_F = [];
    Solid_rho = [];
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Sinking Dinghy
elseif Part_pos_optn == 2
    xmax = 1; % x simulation bound
    ymax = 1; % y simulation bound
    y_bound = 0.3; % y inital position bound
    step = 4/3*y_bound/ceil(sqrt(n)); % x distance between particles
    x = zeros(n, 1);
    y = zeros(n, 1);
    
    % Assign Fluid Positions
    ID1 = 0;
    for IDx1 = step:step:xmax
        for IDy1 = step:step:y_bound
            ID1 = ID1 + 1;
            rx = rand;
            x(ID1) = IDx1*(rx/(rx+0.001));
            ry = rand;
            y(ID1) = IDy1*(ry/(ry+0.001));
        end
    end
    
    % Get N and h
    N = ID1;
    h = sqrt(3*y_bound/N);
    
    % Construct Dinghy Bottom
    particle_spacing = 0.1*h; % set close solid particle spacing
    nD = ceil(0.9*xmax/particle_spacing*0.05/particle_spacing);
    PosSolid = zeros(nD, 2);
    Solid_V = zeros(nD, 2);
    Solid_F = zeros(nD, 2);
    Solid_rho = zeros(nD, 1);
    
    % Assign Particle Positions
    ID2 = 0;
    for IDx2 = 0:particle_spacing:0.3*xmax % first half
        for IDy2 = y_bound:particle_spacing:y_bound+0.02
            ID2 = ID2 + 1;
            PosSolid(ID2, :) = [IDx2, IDy2];
            Solid_V(ID2, :) = [0, -10]; % dinghy moves downward at constant velocity
            Solid_F(ID2, :) = [0, 0];
            Solid_rho(ID2) = 1000;
        end
    end
    for IDx3 = 0.7*xmax:particle_spacing:xmax % second half
        for IDy3 = y_bound:particle_spacing:y_bound+0.02
            ID2 = ID2 + 1;
            PosSolid(ID2, :) = [IDx3, IDy3];
            Solid_V(ID2, :) = [0, -10]; % dinghy moves downward at constant velocity
            Solid_F(ID2, :) = [0, 0];
            Solid_rho(ID2) = 1000;
        end
    end

    % Set external force
    F_ext = [0, 100]; % bouyant force, mimicing an ocean
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compacting Walls
elseif Part_pos_optn == 3
    xmax = 1; % x simulation bound
    ymax = 1; % y simulation bound
    y_bound = 0.4; % y fluid fill line
    x_bound = 0.03; % x position bound
    step = 1/2*(xmax-x_bound)/ceil(sqrt(n)); % x distance between particles
    x = zeros(n, 1);
    y = zeros(n, 1);
    
    % Fill Water
    ID1 = 0;
    for IDx1 = x_bound:step:xmax-x_bound
        for IDy1 = step:step:y_bound
            ID1 = ID1 + 1;
            rx = rand;
            x(ID1) = IDx1*(rx/(rx+0.001));
            ry = rand;
            y(ID1) = IDy1*(ry/(ry+0.001));
        end
    end
    
    % Get N and h
    N = ID1;
    h = sqrt(4*y_bound/N);
    
    particle_spacing = 0.1*h; % set close solid particle spacing
    nD = 2*ceil(x_bound*0.6/step^2);
    PosSolid = zeros(nD, 2);
    Solid_V = zeros(nD, 2);
    Solid_F = zeros(nD, 2);
    Solid_rho = zeros(nD, 1);
    
    % Construct Walls
    ID2 = 0;
    for IDx2 = 0:particle_spacing:x_bound % left wall
        for IDy2 = 0:particle_spacing:0.6*ymax
            ID2 = ID2 + 1;
            PosSolid(ID2, :) = [IDx2, IDy2];
            Solid_V(ID2, :) = [5, 0]; % wall moves right at constant velocity
            Solid_F(ID2, :) = [0, 0];
            Solid_rho(ID2) = 1000;
        end
    end
    for IDx3 = xmax-x_bound:particle_spacing:xmax % right wall
        for IDy3 = 0:particle_spacing:0.6*ymax
            ID2 = ID2 + 1;
            PosSolid(ID2, :) = [IDx3, IDy3];
            Solid_V(ID2, :) = [-5, 0]; % wall moves left at constant velocity
            Solid_F(ID2, :) = [0, 0];
            Solid_rho(ID2) = 1000;
        end
    end
 
    % Set external force
    F_ext = [0, -98]; % gravitational force
end
end
