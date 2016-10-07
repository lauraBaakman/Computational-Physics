function [] = consolidate( prefix )
%CONSILIDATE Consolidate the files of a dataset into one file.

% Find all 2D files
% Check for doubles
% Create empty experiments struct
% For each of the 2D files
    % Read the contents
    % Add to experiments
% Check if 2D.mat already exists
    % IF it existst, write to 2D_date_time.mat and give a warning
    % ELSE Write to 2D.mat
end

function [files] = findFiles(prefix)
    possible_files = dir(sprintf('%s*.mat', prefix));
    
end