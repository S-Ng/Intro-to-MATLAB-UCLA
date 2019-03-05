% NESTED ROOTS
% Simon Ng
% UID: 304993160

% Clear MATLAB Workspace
clear all;
clc;

% Solicit Value For m
m = input('Please enter a value for m: ');
clc;

% Test Value for m and Continue Soliciting
while m <= 1 || mod(m,1) ~= 0
    fprintf('Error: Please enter an integer value for m greater than 1.\n');
    m = input('Please enter a value for m: ');
    clc;
end

% Print m
fprintf('m = %i\n', m);

% Set Initial Conditions for While loop
tOldOdd = sqrt(m); %t1
tOldEven = sqrt(m-sqrt(m)); %t2
count = 2;

% Print t1 and t2
fprintf('t1 = %14.12f\n', tOldOdd)
fprintf('t2 = %14.12f\n', tOldEven)

% Calculate the Limit as t(n+1) - t(n) Goes to 0
while abs(tOldEven-tOldOdd) >= 1*10^-12
    
    % Calculate and Print Odd Terms
    tOldOdd = sqrt(m-sqrt(m+tOldOdd));
    count = count + 1;
    fprintf('t%i = %14.12f\n', count, tOldOdd)
    
    % Calculate and Print Even Terms
    tOldEven = sqrt(m-sqrt(m+tOldEven));
    count = count + 1;
    fprintf('t%i = %14.12f\n', count, tOldEven)
    
end
