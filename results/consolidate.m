function [] = consolidate( regular_expression )
%CONSILIDATE Consolidate the files of a dataset into one file.

    files = findFiles(regular_expression);
    experiments2.parameters = [];
    experiments2.statistics = [];
    
    exp_idx = 1;
    for idx = 1:numel(files)
       new_data = load(files{idx}); 
       statistics = [new_data.experiments.statistics];
       parameters = [new_data.experiments.parameters];
       for new_data_idx = 1:numel(statistics)
           experiments2(exp_idx).statistics = statistics(new_data_idx);
           experiments2(exp_idx).parameters = parameters(new_data_idx);
       end
    end
   
    sprintf('hi!')
        
% Create empty experiments struct
% For each of the 2D files
    % Read the contents
    % Add to experiments
% Check if 2D.mat already exists
    % IF it existst, write to 2D_date_time.mat and give a warning
    % ELSE Write to 2D.mat
end

function [files] = findFiles(regular_expression)
    possible_files = dir();
    possible_files = {possible_files.name}';
    files = {};
    file_idx = 1;
    for i = 1:numel(possible_files)
        file_name = possible_files{i};
        result = regexp(file_name, regular_expression, 'match');
        if ~ isempty(result)
            files{file_idx} = result{1};
            file_idx = file_idx + 1;
        end
    end
end