function neigh = findNeighbors(numrows, numcols, bin)

% FINDNEIGHBORS is a function which identifies the neighboring bins of a
% selected bin in a grid.
%
% FINDNEIGHBORS takes 3 inputs, the number of rows, the number of columns,
% and the bin whose neighbors will be found. It outputs a vector with the 
% list of the neighboring bins of the inputed bin.
%
% There must be at least 2 integer rows and columns, and the bin must be an
% integer contained within the grid.

% Test validity of rows, columns, and bin
if mod(numrows,1) ~= 0
    error('Please enter a whole number of rows.')
elseif mod(numcols,1) ~= 0
    error('Please enter a whole number of columns.')
elseif numrows < 2
    error('Please enter at least 2 rows.')
elseif numcols < 2
    error('Please enter at least 2 columns.')
elseif mod(bin,1) ~= 0
    error('Please enter an integer bin number.')
elseif bin < 1 || bin > numrows*numcols
    error('Please enter a bin number within the array.')
end

% Assign neighbor variables
n1 = bin - numrows - 1;
n2 = bin - numrows;
n3 = bin - numrows + 1;
n4 = bin - 1;
n5 = bin + 1;
n6 = bin + numrows - 1;
n7 = bin + numrows;
n8 = bin + numrows + 1;

% Classify location of bin and its neighbors
if bin == 1
        % Top left corner
        neigh = [n5, n7, n8];
elseif bin < numrows
        % Left wall
        neigh = [n4, n5, n6, n7 , n8];
elseif bin == numrows
        % Bottom left corner
        neigh = [n4, n6, n7];
elseif bin == numrows*numcols - numrows + 1
        % Top right corner
        neigh = [n2, n3, n5];
elseif bin == numrows*numcols
        % Bottom right corner
        neigh = [n1, n2, n4];
elseif bin > numrows*numcols - numrows + 1
        % Right wall
        neigh = [n1, n2, n3, n4, n5];
elseif mod(bin,numrows) == 1
        % Top wall
        neigh = [n2, n3, n5, n7, n8];
elseif mod(bin,numrows) == 0
        % Bottom wall 
        neigh = [n1, n2, n4, n6, n7];
else
        % Middle
        neigh = [n1, n2, n3, n4, n5, n6, n7, n8];
end
