function [neighbors] = OneD2Connected( elementIdx, matrix )
%ONED2CONNECTED The 2-connected neighbours of ELEMENT in the 1D MATRIX.

if length(size(matrix)) ~= 1
   error('Error. \nMatrix must be 1 dimensional not %d-dimensional.',length(size(matrix)))
end

    left_neighbor = [];
    if elementIdx > 1
        left_idx = elementIdx - 1;
        left_neighbor = matrix(left_idx);
    end

    right_neighbor = [];
    if elementIdx < len(matrix)
        right_idx = elementIdx + 1;
        right_neighbor = matrix(right_idx);
    end

    neighbors = [left_neighbor, right_neighbor];
end

