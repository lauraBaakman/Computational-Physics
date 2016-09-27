function [ configuration, energies , magnetizations] = MMCIsing( initialConfiguration, parameters )
%METRPOLOISMONTECARLOISING Solve the Ising model with the MMC method.
%   InitialConfiguration is the initial configuration of the model,
%   parameters contains the parameters used in the simulation. 

relaxedConfiguration = relaxSystem(initialConfiguration, parameters);
[energies, magnetizations, configuration] = sampleSystem(relaxedConfiguration, parameters);

end

function [configuration] = relaxSystem(initialConfiguration, parameters)
    configuration = initialConfiguration;

    for i = 1:parameters.numRelaxIterations
        fprintf('1D: i = %1d\n', i);
        configuration = monteCarloStep(configuration, parameters);
    end
end

function [energies, magnetizations, configuration] = sampleSystem(configuration, parameters)
    previousEnergy = properties.energy(configuration);
    
    energies = nan(parameters.numSampleIterations + 1, 1);
    magnetizations = nan(parameters.numSampleIterations + 1, 1);

    % Store properties of the initial configuration
    energies(1) = previousEnergy;
    magnetizations(1) = sum(sum(configuration, 1), 2);
    
    for i = 1:parameters.numSampleIterations
        fprintf('1D: i = %1d\n', i);
        
        [configuration, deltaE] = monteCarloStep(configuration, parameters); 
        
        energies(i + 1) = previousEnergy + deltaE;
        previousEnergy = energies(i + 1);
        
        magnetizations(i + 1) = sum(sum(configuration, 1), 2);
    end
end

function [configuration, deltaE] = monteCarloStep(configuration, parameters)    
    % Flip a spin
    flippedSpinIdx = randi(numel(configuration));
    
    % Compute Delta E
    padded_configuration = padarray(configuration, [1,1]);
    [x_idx, y_idx] = ind2sub(size(configuration), flippedSpinIdx);    
    deltaE = -2 * (configuration(flippedSpinIdx) * -1) * (...
        padded_configuration(x_idx + 2, y_idx + 1) + ...
        padded_configuration(x_idx + 1, y_idx + 2) + ...
        padded_configuration(x_idx,     y_idx + 1) + ...
        padded_configuration(x_idx + 1, y_idx));
    
    % Select a new configuration
    xi = exp(- (1 / parameters.temperature) * deltaE);
    theta = rand();
    if xi > theta
        configuration(flippedSpinIdx) = configuration(flippedSpinIdx) * -1;
    else
        deltaE = 0;
    end
end