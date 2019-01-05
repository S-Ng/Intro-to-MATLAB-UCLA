function [ xs ] = splitPts( x )
% SPLITPTS Add the average of two adjacent cells into a new cell between
% the two. 
%
% The SPLITPTS function takes in a 1 x n vector and produces a
% vector which is 1 x 2*n. 
%
% The odd entries of the new vector are copied in order from the old 
% vector, and the even entries of the new vector are the average of their 
% neighboring entries in the old vector.
%
% The last entry of the new vector is calculated using the previous entry 
% and the first entry of the old vector. This treats the old vector as if
% it were a ring, with the first and last entries acting as neighbors.
%
% For example, if the input vector is [ 1 3 2 ], the output vector will be
% [ 1 2 3 2.5 2 1.5 ].

length_x = length(x);

%Initialize Size of Split Vector xs
xs = zeros(1, 2*length_x);

% For Loop to retrieve xs from x
for k = 1:length_x
    xs(2*k-1) = x(k);
end
for k = 1:length_x - 1
    xs(2*k) = (x(k)+x(k+1))/2;
end

% Set Last New Point
xs(2*length_x) = (x(length_x)+x(1))/2;
end