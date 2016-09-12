function [ configurations ] = metropolisMonteCarloIsing( initialConfiguration, parameters )
%METRPOLOISMONTECARLOISING Solve the Ising model with the MMC method.
%   InitialConfiguration is the initial configuration of the model,
%   parameters contains the parameters used in the simulation. 

configurations = nan([size(initialConfiguration), parameters.numSampleIterations]);

configuration = initialConfiguration;

for i = 1:paramters.numRelaxIterations
    configuration = monteCarloStep(configuration);
end

for i = 1:parameters.numSampleIterations
   configuration = monteCarloStep(parameters.beta, configuration);
   configurations(:,:, i) = configuration;
end

end

function [nextConfig] = monteCarloStep(currentConfig, parameters)
    potentialConfig, flippedSpin = flipRandomSpin(current);
    nextConfig = selectNextConfig(currentConfig, potentialConfig, flippedSpin, parameters);
end

function [potentialConfig, flippedSpinIdx] = flipRandomSpin(currentConfig)
    potentialConfig = currentConfig;
    flippedSpinIdx = randi(numel(potentialConfig));
    potentialConfig(randomIdx) = potentialConfig(randomIdx) * -1;
end

function [nextConfig] = selectNextConfig(currentConfig, potentialConfig, flippedSpin, parameters)
    deltaE = computeDeltaE(potentialConfig, flippedSpin);
    xi = exp(- parameters.beta * deltaE);
    theta = rand();
    if xi > theta
        nextConfig = potentialConfig;
    else
        nextConfig = currentConfig;
    end
end

function [deltaE] = computeDeltaE(potentialConfig, flippedSpinIdx, parameters)
    neighbors = parameters.neighbourFunction(flippedSpinIdx, potentialConfig);
    deltaE = -2 * potentialConfig(flippedSpin) * sum(neighbors);
end
