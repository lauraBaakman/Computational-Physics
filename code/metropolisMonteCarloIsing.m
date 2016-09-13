function [ configurations ] = metropolisMonteCarloIsing( initialConfiguration, parameters )
%METRPOLOISMONTECARLOISING Solve the Ising model with the MMC method.
%   InitialConfiguration is the initial configuration of the model,
%   parameters contains the parameters used in the simulation. 

relaxedConfiguration = relaxSystem(initialConfiguration, parameters);
configurations = sampleSystem(relaxedConfiguration, parameters);

end

function [configuration] = relaxSystem(initialConfiguration, parameters)
    configuration = initialConfiguration;

    for i = 1:parameters.numRelaxIterations
        configuration = monteCarloStep(configuration, parameters);
    end
end

function [configurations] = sampleSystem(configuration, parameters)
    configurations = nan([size(configuration), parameters.numSampleIterations]);
    
    % Store the initial configuration
    configurations(:,:,1) = configuration;
    
    for i = 1:parameters.numSampleIterations
       configuration = monteCarloStep(configuration, parameters);
       configurations(:,:, i + 1) = configuration;
    end
end

function [nextConfig] = monteCarloStep(currentConfig, parameters)
    [potentialConfig, flippedSpinIdx] = flipRandomSpin(currentConfig);
    nextConfig = selectNextConfig(currentConfig, potentialConfig, flippedSpinIdx, parameters);
end

function [potentialConfig, flippedSpinIdx] = flipRandomSpin(currentConfig)
    potentialConfig = currentConfig;
    flippedSpinIdx = randi(numel(potentialConfig));
    potentialConfig(flippedSpinIdx) = potentialConfig(flippedSpinIdx) * -1;
end

function [nextConfig] = selectNextConfig(currentConfig, potentialConfig, flippedSpinIdx, parameters)
    deltaE = computeDeltaE(potentialConfig, flippedSpinIdx, parameters);
    xi = exp(- (1 / parameters.temperature) * deltaE);
    theta = rand();
    if xi > theta
        nextConfig = potentialConfig;
    else
        nextConfig = currentConfig;
    end
end

function [deltaE] = computeDeltaE(potentialConfig, flippedSpinIdx, parameters)
    neighbors = parameters.neighborFunction(flippedSpinIdx, potentialConfig);
    deltaE = -2 * potentialConfig(flippedSpinIdx) * sum(neighbors);
end
