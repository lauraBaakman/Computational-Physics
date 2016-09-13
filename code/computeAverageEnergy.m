function [ average, energies ] = computeAverageEnergy( configurations )
%COMPUTEAVERAGEENERGY Compute the average energy of a list of configurations. 
% Energies is the list of energies that the average is based on.

    [dimension, ~, ~] = size(configurations);
    if dimension == 1
        [average, energies] = averageEnergy1D(configurations);
    else
        [average, energies] = averageEnergy2D(configurations);
    end

end

function [average, energies] = averageEnergy1D( configurations )
    [~, ~, num_configurations] = size(configurations);
    shifted_left = [zeros(1, 1, num_configurations), configurations];
    shifted_right = [configurations, zeros(1, 1, num_configurations)];
    multiplied = shifted_left .* shifted_right;
    energies = -1 * sum(multiplied, 2);
    average = mean(energies);
end

function [average, energies] = averageEnergy2D( configurations )
    error('Error. \nNot yet implemented.');
end