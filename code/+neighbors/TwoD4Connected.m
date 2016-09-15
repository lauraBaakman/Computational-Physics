function [ neighbors ] = TwoD4Connected( elementIdx, matrix )
%TWOD4CONNECTED The 2-connected neighbours of ELEMENT in  the 2D MATRIX.

    if length(size(matrix)) ~= 2
       error('Error. \nMatrix must be 2 dimensional not %d-dimensional.',...
           length(size(matrix)))
    end

    [row, col] = ind2sub(size(matrix), elementIdx);

    left = left_neighbor(row, col, matrix);
    right = right_neighbor(row, col, matrix);
    top = top_neighbor(row, col, matrix);
    bottom = bottom_neighbor(row, col, matrix);

    neighbors = [left, right, top, bottom];
end

function[left] = left_neighbor(row, col, matrix)
    left = [];
    if col > 1
        left_idx = col - 1;
        left = matrix(row, left_idx);
    end
end

function[right] = right_neighbor(row, col, matrix)
    right = [];
    if col < size(matrix, 2)
        right_idx = col + 1;
        right = matrix(row, right_idx);
    end
end

function [top] = top_neighbor(row, col, matrix)
    top = [];
    if row > 1
        top_idx = row - 1;
        top = matrix(top_idx, col);
    end
end

function [bottom] = bottom_neighbor(row, col, matrix)
    bottom = [];
    if row < size(matrix, 1)
        bottom_idx = row + 1;
        bottom = matrix(bottom_idx, col);
    end
end