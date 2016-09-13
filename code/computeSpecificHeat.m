function [ specificHeat ] = computeSpecificHeat( configurations, temperature)
%COMPUTESPECIFICHEAT Compute the specific heat of a set of configurations.
    [U, energies] = computeAverageEnergy(configurations);
    beta = (1 / temperature);
    [~, ~, number_of_configurations] = size(configurations);
    specificHeat = beta^2 * ( (1/number_of_configurations) * sum(energies.^2)  - U.^2);
end


