function [ specificHeat ] = specificHeat( temperature,  energies)
%SPECIFICHEAT Compute the specifcheat based on the energies of the configurations.

    beta = 1/ temperature;
    numberOfConfigurations= length(energies);
    U = mean(energies);
    specificHeat = beta^2 * ( (1/numberOfConfigurations) * sum(energies.^2)  - U.^2);    

end

