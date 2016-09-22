function [ configurations, U ] = MMCIsing( initialConfiguration, parameters )
%METRPOLOISMONTECARLOISING Solve the Ising model with the MMC method.
%   InitialConfiguration is the initial configuration of the model,
%   parameters contains the parameters used in the simulation. 

relaxedConfiguration = relaxSystem(initialConfiguration, parameters);
[configurations, U] = sampleSystem(relaxedConfiguration, parameters);

end

function [configuration] = relaxSystem(initialConfiguration, parameters)
    configuration = initialConfiguration;

    for i = 1:parameters.numRelaxIterations
        configuration = monteCarloStep(configuration, parameters);
    end
end

function [configurations, U] = sampleSystem(configuration, parameters)
    previousEnergy = computeEnergy(configuration);
    
    energies = nan(parameters.numSampleIterations + 1, 1);
    configurations = nan([size(configuration), parameters.numSampleIterations + 1]);
    
    
    
    % Store the initial configuration
    configurations(:,:,1) = configuration;    
    energies(1) = previousEnergy;
    
    for i = 1:parameters.numSampleIterations
        [configuration, deltaE] = monteCarloStep(configuration, parameters); 
        
        configurations(:,:, i + 1) = configuration;
        
        energies(i + 1) = previousEnergy + deltaE;
        previousEnergy = energies(i + 1);
    end
    
    U = mean(energies);
end

function [nextConfig, deltaE] = monteCarloStep(curConfig, parameters)
    [potConfig, flippedSpinIdx] = flipRandomSpin(curConfig);
    [nextConfig, deltaE] = selectNextConfig(curConfig, potConfig,...
        flippedSpinIdx, parameters);
end

function [potentialConfig, flippedSpinIdx] = flipRandomSpin(currentConfig)
    potentialConfig = currentConfig;
    flippedSpinIdx = randi(numel(potentialConfig));
    potentialConfig(flippedSpinIdx) = potentialConfig(flippedSpinIdx) * -1;
end

function [nextConfig, deltaE] = selectNextConfig(currentConfig, potentialConfig, flippedSpinIdx, parameters)
    deltaE = computeDeltaE(potentialConfig, flippedSpinIdx, parameters);
    xi = exp(- (1 / parameters.temperature) * deltaE);
    theta = rand();
    if xi > theta
        nextConfig = potentialConfig;
    else
        nextConfig = currentConfig;
        deltaE = 0;
    end
end

function [deltaE] = computeDeltaE(potentialConfig, flippedSpinIdx, parameters)
    neighbors = parameters.neighborFunction(flippedSpinIdx, potentialConfig);
    deltaE = -2 * potentialConfig(flippedSpinIdx) * sum(neighbors);
end
