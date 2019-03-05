function [ xa ] = averagePts( xs, w )
% AVERAGEPTS Calculate a new cell entry based on a weighted average of the 
% original cell's left and right neighbors and itself.
%
% The AVERAGEPTS function takes two vector arguments separated by commas in
% the form averagePts(x,w).
% The first vector, x, is the vector to take the weighted average of, and the
% second vector, w, is the 3 cell weighting vector. The first vector is treated
% as if it were circular such that the last cell and first cell are
% neighbors.
%
% The sum of the weights cannot equal 0.
%
% For example, if the input, x, is [ 1 7 2 5 ] and the weight vector, w, is 
% [ 1 2 1 ], then averagePts(x,w) will output the vector [ 3.5 4.25 4 3.25 ].

% Error if components of w sum to 0
if sum(w) == 0
    error('Sum of weights cannot equal 0.');
end

% Calculate Normalized Weights
w1 = w(1)/sum(w);
w2 = w(2)/sum(w);
w3 = w(3)/sum(w);

% Initialize Average Vector xa
length_xs = length(xs);
xa = zeros(1, length_xs);

% Set Middle Point Averages
for j = 2:length_xs-1
    xa(j) = w1*xs(j-1) + w2*xs(j) + w3*xs(j+1);
end

% Set First and Last Point Averages
xa(1) = w1*xs(length_xs) + w2*xs(1) + w3*xs(2);
xa(length_xs) = w1*xs(length_xs-1) + w2*xs(length_xs) + w3*xs(1);

end
