function [ y ] = advanceRK( y, dt, method )
% ADVANCERK is a function that runs the Runge-Kutta radioactive decay 
% method.
% The ADVANCERK function has 3 built in approximations to select from, 
% a first order approximation RK1, a second order approximation RK2, and
% a fourth order approximation RK4. RK1 is selected when method = 1, 
% RK2 when method = 2, and RK4 when method = 4.
% The ADVANCERK function accepts three inputs, the amount of material remaining,
% y, the time step, dt, and the method desired.
% The half life is built in as 2.45 seconds, the half life of carbon-15.

% Set half_life of carbon-15
half_life = 2.45;

% Calculate c1, which is used in all methods
c1 = dt * (-log(2) / half_life) * y;

% Check for RK1
if method == 1
    % Finish RK1
    [ y ] = y + c1;
    
else % Move to RK2 and RK4
    % Calculate c2, which is used for RK2 and RK4
    c2 = dt * (-(log(2)) / half_life) * (y + c1/2);
    
    % Check for RK2
    if method == 2
        % Finish RK2
        [ y ] = y + c2;
        
    else % Move to RK4
        % Finish RK4
        c3 = dt * (-(log(2)) / half_life) * (y + c2/2);
        c4 = dt * (-(log(2)) / half_life) * (y + c3);
        [ y ] = y + c1/6 + c2/3 + c3/3 + c4/6;
        
    end
end

end
