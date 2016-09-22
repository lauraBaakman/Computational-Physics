function [ energies ] = energy( configurations )
%ENERGY Compute energies of a (list of) configuration(s).

    numConfigurations = size(configurations, 3);
    
    extra_column = zeros(size(configurations, 1), 1, numConfigurations);
    shifted_left = [extra_column, configurations];
    shifted_right = [configurations, extra_column];
    col_term = shifted_left .* shifted_right;
    col_term_sum = sum(sum(col_term, 1), 2);
    
    % This term is always zero for 1D models.
    extra_row = zeros(1, size(configurations, 2), numConfigurations);
    shifted_top = [extra_row; configurations];
    shifted_down = [configurations; extra_row];
    row_term = shifted_down .* shifted_top;
    row_term_sum = sum(sum(row_term, 1), 2);
    
    energies = - col_term_sum - row_term_sum;

end

