clc; close all; clear all;
rng('default');

computeNumRelaxIterations = @(n) 1/10 .* n;

%% Init 
temperatures = 0.2:0.2:4;
numParticlesList = [10, 100, 1000];
numIterationsList = [1000, 10000];

idx = 1;

%% Run Simulations
for numParticles = numParticlesList
    for numIterations =  numIterationsList
        
        numSampleIterations = numIterations * numParticles;
        numRelaxIterations = computeNumRelaxIterations(numSampleIterations);
        
        initialConfiguration = ones([1, numParticles]);
        
        for temperature = temperatures
            
            fprintf('1D: T = %1.1f N = %4d N_it = %8d\n', temperature, numParticles, numSampleIterations);
            
            parameters = struct(...
                'temperature', temperature,...
                'numParticles', numParticles,...
                'numSampleIterations', numSampleIterations,...
                'numRelaxIterations', numRelaxIterations);
            
            [initialConfiguration, energies, ~] = MMCIsing(initialConfiguration, parameters);
            
            experiments(idx).parameters = parameters;
            
            U = mean(energies);
            C = properties.specificHeat(temperature, energies);
            
            experiments(idx).statistics = struct(...
                'averageEnergy', U,...
                'specificHeat', C);
            idx = idx + 1;
        end
    end
end

%% Store the results
save('../results/1D.mat', 'experiments')