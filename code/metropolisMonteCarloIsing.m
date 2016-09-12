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
   configuration = monteCarloStep(configuration);
   configurations(:,:, i) = configuration;
end

end

function [nextConfig] = monteCarloStep(currentConfig)
    potentialConfig = flipRandomSpin(current);
    nextConfig = selectNextConfig(currentConfig, potentialConfig);
end

function [potentialConfig] = flipRandomSpin(currentConfig)
    potentialConfig = currentConfig;
    randomIdx = randi(numel(potentialConfig));
    potentialConfig(randomIdx) = potentialConfig(randomIdx) * -1;
end

function [nextConfig] = selectNextConfig(currentConfig, potentialConfig)
    sprintf('Not yet Implemented')
end
