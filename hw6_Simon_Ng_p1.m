% THE SHARED BIRTHDAY PROBLEM
% Simon Ng
% UID: 304993160

% Clear MATLAB Workspace
clear all;
clc;

% Initialize Size of Arrays
Num_Ppl = zeros(1, 1*10^4);
birthday = zeros(1, 100);

% Run Trial 10 Thousand Times
for k = 1:10^4
    
    % Set Random Birthdays Array
    birthday = randi(365, 1, 100);
    person_2 = 2;
    match = 0;
    
    while match == 0
        
        % Set Array of Previous People's Birthdays
        person_1 = linspace(1, person_2-1, person_2-1);
        
        for j = 1:person_2-1
            
            if (abs(birthday(person_1(j)) - birthday(person_2))) < 7
                match = 1;
                
            elseif (abs(birthday(person_1(j)) - birthday(person_2))) > 357
                match = 1;
                
            end
            
        end
        
        % Uncover Next Person's Birthday
        person_2 = person_2 + 1;
        
    end
    
    % Store Trial Results
    Num_Ppl(k) = person_2;
    
end

% Print Result
Med_Num_Ppl = median(Num_Ppl);
Med_Num_Ppl_RndUp = ceil(Med_Num_Ppl);
if Med_Num_Ppl_RndUp < 10
    fprintf('Median Number of People = 0%i\n', Med_Num_Ppl_RndUp);
else
    fprintf('Median Number of People = %i\n', Med_Num_Ppl_RndUp);
end

% Plot Histogram
figure
histogram(Num_Ppl);
xlabel('Number of People');
ylabel('Number of Trials');
title('Histogram: Group Size Required for 2 Birthdays in Same Week');