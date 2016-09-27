clc; close all; clear all;
rng('default');

computeNumRelaxIterations = @(n) 1/10 .* n;

%% Init 
temperatures = 0.2:0.2:4;
numParticlesList = [10, 100, 1000];
numSampleIterationsList = [1000, 10000];

idx = 1;

%% Run Simulations
for numParticles = numParticlesList
    for numSampleIterations =  numSampleIterationsList
        
        actualNumSampleIterations = numSampleIterations * numParticles;
        numRelaxIterations = computeNumRelaxIterations(actualNumSampleIterations);
        
        initialConfiguration = ones([1, numParticles]);
        
        for temperature = temperatures
            
            fprintf('1D: T = %1.1f N = %4d N_it = %8d\n', temperature, numParticles, actualNumSampleIterations);
            
            parameters = struct(...
                'temperature', temperature,...
                'numParticles', numParticles,...
                'numSampleIterations', actualNumSampleIterations,...
                'numRelaxIterations', numRelaxIterations,...
                'neighborFunction', @neighbors.OneD2Connected);
            
            [initialConfiguration, energies, ~] = MMCIsing(initialConfiguration, parameters);
            
            parameters = rmfield(parameters, 'neighborFunction');
            
            experiments(idx).parameters = parameters;
            
            U = mean(energies);
            C = properties.specificHeat(temperature, energies);
            
            experiments(idx).statistics = struct(...
                'averageEnergy', U,...
                'specificHeat', C);
            idx = idx + 1;
        end
        save(sprintf('../results/1D%d_%d.mat', numParticles, numSampleIterations), 'experiments')
    end
end

%% Store the results
save('../results/1D.mat', 'experiments')