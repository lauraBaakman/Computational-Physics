function [ average ] = averageEnergy( configurations )
%AVERAGEENERGY Compute the average energy of a list of configurations.

    [dimension, ~, ~] = size(configurations);
    if dimension == 1
        average = averageEnergy1D(configurations);
    else
        average = averageEnergy2D(configurations);
    end

end

function [average] = averageEnergy1D( configurations )
    [~, ~, num_configurations] = size(configurations);
    shifted_left = [zeros(1, 1, num_configurations), configurations];
    shifted_right = [configurations, zeros(1, 1, num_configurations)];
    
    energy_per_configuration = -1 * sum(multiplied, 2);
    average = mean(energy_per_configuration);
end

function [average] = averageEnergy2D( configurations )
    error('Error. \nNot yet implemented.');
end