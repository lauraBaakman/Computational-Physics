function [ configuration, energies , magnetizations] = MMCIsing( configuration, parameters )
%METRPOLOISMONTECARLOISING Solve the Ising model with the MMC method.
%   Configuration is the initial configuration of the model,
%   parameters contains the parameters used in the simulation.

    % Relax the system
    for i = 1:parameters.numRelaxIterations
        configuration = monteCarloStep(configuration, parameters);
    end
    
    previousEnergy = properties.energy(configuration);

    % Preallocate
    energies = nan(parameters.numSampleIterations + 1, 1);
    magnetizations = nan(parameters.numSampleIterations + 1, 1);

    % Store properties of the initial configuration
    energies(1) = previousEnergy;
    magnetizations(1) = sum(sum(configuration, 1), 2);

    % Sample the system
    for i = 2:(parameters.numSampleIterations + 1)
        [configuration, deltaE] = monteCarloStep(configuration, parameters);

        energies(i) = previousEnergy + deltaE;
        previousEnergy = energies(i);

        magnetizations(i) = sum(sum(configuration, 1), 2);
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
            bottom = configuration(row + 1, col);
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