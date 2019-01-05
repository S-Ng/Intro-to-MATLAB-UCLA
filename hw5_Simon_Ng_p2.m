% Runge-Kutta Radioactivity
% Simon Ng
% UID: 304993160

% Clean Up MATLAB Workspace
clear all;
clc;

% Initialize Time Step
tTotal = 15;
deltaT = [ 1 0.1 0.01 ];

% Print Table Heading
fprintf('  dt  RK1       RK2     RK4\n');

% Run Script for 3 dt Values
for j = 1:3
    dt = deltaT(j);
    
    % Initialize Variables and Set Array Sizes
    
    numberSteps = ceil(tTotal / dt) + 1;
    
    yExact = zeros(1, numberSteps);
    y1 = zeros(1, numberSteps);
    y2 = zeros(1, numberSteps);
    y4 = zeros(1, numberSteps);
    t = zeros(1, numberSteps);
    
    t(1) = 0;
    for s = 1:numberSteps-1
        t(s+1) = t(s) + dt;
    end
    
    y0 = 1;
    half_life = 2.45;
    
    a = y0;
    b = y0;
    c = y0;
    
    y1(1) = 1;
    y2(1) = 1;
    y4(1) = 1;
    
    % Calculate Exact Solution
    for h = 1:numberSteps
        yExact(h) = y0 * exp( -log(2) / half_life * t(h));
    end
    
    for k = 2:numberSteps
        
        % Calculate RK1
        method = 1;
        y1(k) = advanceRK(a,dt,method);
        a = y1(k);
        
        % Calculate RK2
        method = 2;
        y2(k) = advanceRK(b,dt,method);
        b = y2(k);
        
        % Calculate RK4
        method = 4;
        y4(k) = advanceRK(c,dt,method);
        c = y4(k);
        
    end
    
    % Calculate and Print Error of RK1, RK2, and RK4
    absdiff_RK1 = zeros(1, numberSteps);
    absdiff_RK2 = zeros(1, numberSteps);
    absdiff_RK4 = zeros(1, numberSteps);
    absdiff_RK1 = abs(y1-yExact);
    absdiff_RK2 = abs(y2-yExact);
    absdiff_RK4 = abs(y4-yExact);
    
    diff_RK1 = mean(absdiff_RK1);
    diff_RK2 = mean(absdiff_RK2);
    diff_RK4 = mean(absdiff_RK4);
    fprintf('%.2f: %.2e %.2e %.2e\n', dt, diff_RK1, diff_RK2, diff_RK4);
    
    % Print Graphs
    figure
    plot(t, yExact, t, y1, t, y2, t, y4);
    legend('Exact Method', 'First Order', 'Second Order', 'Fourth Order')
    xlabel('Time (s)')
    ylabel('Remaining Carbon-15')
    title('Runge-Kutta Approximations for Carbon-15 Radioactive Decay')
end

