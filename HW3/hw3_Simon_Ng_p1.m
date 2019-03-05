% THE THREE SPECIES PROBLEM
% Simon Ng
% UID: 304993160


% Clear MATLAB Workspace
clear all;
clc;

% Define Initial Population Conditions
Xold = 2;
Yold = 2.49;
Zold = 1.5;

% Define Time Stepping Conditions
Ttotal = 12;
dT = 0.001;

% Print Table Header and Initial Value
fprintf('Time      X      Y      Z\n');

% FOR Loop for Discrete Population Calculation
tic
for T = 0:dT:Ttotal
    
    % Discretized Lotka-Volterra Equations
    Xnew = Xold + dT*(0.75*Xold*(1 - Xold/20) - 1.5*Xold*Yold - 0.5*Xold*Zold);
    Ynew = Yold + dT*(Yold*(1 - Yold/25) - 0.75*Xold*Yold - 1.25*Yold*Zold);
    Znew = Zold + dT*(1.5*Zold*(1 - Zold/30) - Xold*Zold - Yold*Zold);
    
    % Print X, Y, and Z corresponding to t before the discrete change
    if mod(T,0.5) == 0
        fprintf('%4.1f  %5.2f  %5.2f  %5.2f\n', T, Xold, Yold, Zold)
    end
    
    % Redefine X, Y, and Z old to reiterate
    Xold = Xnew;
    Yold = Ynew;
    Zold = Znew;
end
fprintf('\ndT = %5.3e\n', dT)
toc
