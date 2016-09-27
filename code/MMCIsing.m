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
        [configuration, deltaE] = monteCarloStep(configuration, parameters);

        energies(i + 1) = previousEnergy + deltaE;
        previousEnergy = energies(i + 1);

        magnetizations(i + 1) = sum(sum(configuration, 1), 2);
    end
end

function [configuration, deltaE] = monteCarloStep(configuration, parameters)

    function [ neighbors ] = findNeighbours()
        [numberOfConfigurationRows, numberOfConfigurationColumns] = size(configuration);
        [row, col] = ind2sub(size(configuration), flippedSpinIdx);
        
        if col > 1
            left = configuration(row, col - 1);
        else
            left = [];
        end;
        
        if col < numberOfConfigurationColumns
            right = configuration(row, col + 1);
        else
            right = [];
        end;
        
        if row > 1
            top = configuration(row - 1, col);
        else
            top = [];
        end
        
        if row < numberOfConfigurationRows
            bottom = configuration(bottom_idx, col);
        else 
            bottom = [];
        end

        neighbors = [left, right, top, bottom];
    end

        % Flip a spin
        flippedSpinIdx = randi(numel(configuration));
        
        % Compute Delta E
        neighbours = findNeighbours();
        deltaE = -2 * (configuration(flippedSpinIdx) * -1) * sum(neighbours);
        
        % Select a new configuration
        xi = exp(- (1 / parameters.temperature) * deltaE);
        theta = rand();
        if xi > theta
            configuration(flippedSpinIdx) = configuration(flippedSpinIdx) * -1;
        else
            deltaE = 0;
        end
    end