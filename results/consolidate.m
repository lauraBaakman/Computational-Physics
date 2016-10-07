function [] = consolidate( regular_expression, output_file )
%CONSILIDATE Consolidate the files of a dataset into one file.

    files = findFiles(regular_expression);
    
    new_data = load(files{1});
    experiments2 = new_data.experiments;
    for idx = 2:numel(files)
       new_data = load(files{idx}); 
       experiments2 = [experiments2 new_data.experiments];
    end
       
    writeToFile(experiments2, output_file);
    
end

function [] = writeToFile(experiments, output_file)
    if exist(output_file)
       warning('The file %s is overwritten.', output_file);
    end
    save(output_file, 'experiments');
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