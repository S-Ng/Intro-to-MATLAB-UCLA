% LUNAR PHASE CALCULATOR
% This script calculates lunar phase based on a user-specified date
% Simon Ng
% UID: 304993160

% CLEAN UP MATLAB WORKSPACE
clear all;
clc;

% REQUEST USER-INPUT DATE

MMM = input('Please enter the month as MMM (e.g. JAN): ', 's');
DD = input('Please enter the day as DD (e.g. 01): ', 's');
YYYY = input('Please enter the year as YYYY (e.g. 2000): ', 's');

% TEST THE VALIDITY OF THE YEAR INPUT

    % Test for a 4 digit year entry
    if length(YYYY) ~= 4
        error('Please enter a year with 4 integer numbers between 1900 and 9999.')
    end
    
    % Test for all numbers
    [Year, flagYearConversion] = str2num(YYYY);
    if flagYearConversion == 0
        error('Please enter a year with 4 integer numbers between 1900 and 9999.')
    end
    
    % Test that year is an integer
    if mod(Year,1) ~= 0
        error('Please enter a year with 4 integer numbers between 1900 and 9999.')
    end
    
    % Test that year is between 1900 and 9999
    if Year < 1900 || Year > 9999
        error('Please enter a year between 1900 and 9999.')
    end

% TEST THE VALIDITY OF THE MONTH INPUT and
% SET MAXIMUM NUMBER OF DAYS AND SET OFFSET VALUE FOR LATER CALCULATIONS

switch (MMM)
    case 'JAN'
         Month = 1;
         max_days = 31;
         a = 1;
    case 'FEB'
        Month = 2;
        if mod(Year,4) == 0 && mod(Year,100) ~= 0 || mod(Year,400) == 0
            max_days = 29;
        else max_days = 28;
        end
        a = 1;
    case 'MAR'
        Month = 3;
        max_days = 31;
        a = 0;
    case 'APR'
        Month = 4;
        max_days = 30;
        a = 0;
    case 'MAY'
        Month = 5;
        max_days = 31;
        a = 0;
    case 'JUN'
        Month = 6;
        max_days = 30;
        a = 0;
    case 'JUL'
        Month = 7;
        max_days = 31;
        a = 0;
    case 'AUG'
        Month = 8;
        max_days = 31;
        a = 0;
    case 'SEP'
        Month = 9;
        max_days = 30;
        a = 0;
    case 'OCT'
        Month = 10;
        max_days = 31;
        a = 0;
    case 'NOV'
        Month = 11;
        max_days = 30;
        a = 0;
    case 'DEC'
        Month = 12;
        max_days = 31;
        a = 0;
    otherwise 
        error('Please enter the month as MMM (e.g. JAN).')
end

% TEST VALIDITY OF DAY INPUT
    
    % Test for a 2 digit entry for day
    if length(DD) ~= 2
        error('Please enter the day as a 2 digit integer number.')
    end
    
    % Test for all numbers
    [Day, flagDayConversion] = str2num(DD);
    if flagDayConversion == 0
        error('Please enter the day as a 2 digit integer number.')
    end
           
    % Test that day is an integer
    if mod(Day,1) ~= 0
        error('Please enter the day as a 2 digit integer number.')
    end
    
    % Test that day is between 01 and max_days
    if Day < 1 || Day > max_days
        error(['Please enter a valid day for the month of ', MMM, '.'])
    end
    
% CALCULATE THE ELAPSED NUMBER OF DAYS SINCE JANUARY 1, 1900

% Convert year and month into Julian equation format
y = Year - a + 4800;
m = Month + 12*a - 3;

% Calculate the Julian Day Number
    J1 = floor((153*m + 2)/5);
    J2 = floor(y/4);
    J3 = floor(y/100);
    J4 = floor(y/400);
J = Day + J1 + 365*y + J2 - J3 + J4 - 32045;

% Calculate number of days since January 1, 1900
     J0 = 2415021;
deltaJ = J - J0;

%CALCULATE LUNAR PHASE AND ILLUMINATION

    T = 29.530588853;
    L1 = mod(deltaJ,T)/T;
    L2 = sin(pi*L1);
L = L2^2;
I = L*100;

% PRINT DATE, ILLUMINATION, AND LUNAR PHASE

fprintf('\n')
fprintf('%s %s %s:\n', MMM, DD, YYYY)
fprintf('Illumination = %4.1f percent\n', I)
if L1 < 0.5
    fprintf('Waxing\n')
else
    fprintf('Waning\n')
end
