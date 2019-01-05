% DNA ANALYSIS
% Simon Ng
% UID: 304993160

% Clear MATLAB Workspace
clear all;
clc;

% Load DNA Segment
load('chr1_sect.mat');

% Find Length of DNA Segment
NumberBases = length(dna);

% Set Initial Conditions
StartPoint = 0;
SegmentCount = 0;
count_TAA = 0;
count_TAG = 0;
count_TGA = 0;

% Initialize Codon Array (used to test for start & stop codons)
codon = zeros(1, 3);

% Iterate All Codons
for k = 1:3:NumberBases-2
    
    % Define Codon Array
    codon = [dna(k) dna(k+1) dna(k+2)];
    
    % Start Codon
    if StartPoint == 0
        
        % Set logical array to look for start codons
        ATG = codon == [1 4 3];
        
        if all(ATG) == 1 % Search for start codon
            StartPoint = k; % Set start point
        end
        
    % End Codon
    else % DNA is in coding region, so begin search for end codon
        
        % Set logical array for stop codons
        TAA = codon == [4 1 1];
        TAG = codon == [4 1 3];
        TGA = codon == [4 3 1];
        
        if all(TAA) == 1 || all(TAG) == 1 || all(TGA) == 1
            EndPoint = k; % Set end point
            SegmentCount = SegmentCount + 1; % Move to next entry of output array (dna_stats)
            dna_stats(SegmentCount) = EndPoint - StartPoint + 3; % Record number of bases in output array
          
%             Find Granular Data on Coding Segments Within DNA Segment
%             if SegmentCount < 6
%             fprintf('Segment: %i\n Start Point: %i\n', SegmentCount, StartPoint);
%             end
            
            StartPoint = 0; % Reset start point so next iteration looks for start codon
           
            % Find functional number of each stop codon
            if all(TAA) == 1
                count_TAA = count_TAA + 1;
            elseif all(TAG) == 1
                count_TAG = count_TAG + 1;
            elseif all(TGA) == 1
                count_TGA = count_TGA + 1;
            end
        end
    end
end

% Calculate and Print Results
Number_Coding_Regions = length(dna_stats); % Find number of coding segments
fprintf('Total Protein-Coding Segments: %i\n', Number_Coding_Regions);

Average_Length = mean(dna_stats); % Find average segment length
fprintf('Average Length: %.2f\n', Average_Length);

Max_Length = max(dna_stats); % Find maximum segment length
fprintf('Maximum Length: %i\n', Max_Length);

Min_Length = min(dna_stats); % Find minimum segment length
fprintf('Minimum Length: %i\n', Min_Length);

% Print functional number of each stop codon
fprintf('Number of functional TAA codons: %i\n', count_TAA);
fprintf('Number of functional TAG codons: %i\n', count_TAG);
fprintf('Number of functional TGA codons: %i\n', count_TGA);

Total_Bases = sum(dna_stats); % Find percentage of coding bases
Percent_Coding_Bases = Total_Bases/NumberBases*100;
fprintf('Percentage of Coding Bases: %.2f%%\n', Percent_Coding_Bases);
