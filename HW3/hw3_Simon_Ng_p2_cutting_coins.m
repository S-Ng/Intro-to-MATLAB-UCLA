% POCKET CHANGE PROBLEM
% Simon Ng
% UID: 304993160

% Clear MATLAB Workspace
clear all;
clc;

% Define Initial Coin Count Value
sum = 0;

% Calculate Number of Coins Needed for All Change Values
for targetCents = 0:99
    
    % Define variable for within the While loop
    target = targetCents;
    
    % Calculate number of coins needed to make change for each coin
    while target ~= 0
        % Reset count for each While loop iteration
        count = 0;
        
        % Determine which coins fit into target value and add to count
        if target >= 29
            target = target - 29;
            count = 1;
        elseif target >= 11
            target = target - 11;
            count = 1;
        elseif target >= 3
            target = target - 3;
            count = 1;
        else
            target = target - 1;
            count = 1;
        end
        
        % Add total count for given value to total sum count of all coins
        sum = sum + count;
    end
end

% Calculate Average
average = sum/100;

% Print Average
fprintf('Average Number of Coins = %.2f\n', average)

