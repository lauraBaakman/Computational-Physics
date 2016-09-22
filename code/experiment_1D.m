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
            
            parameters = struct(...
                'temperature', temperature,...
                'numParticles', numParticles,...
                'numSampleIterations', actualNumSampleIterations,...
                'numRelaxIterations', numRelaxIterations,...
                'neighborFunction', @neighbors.OneD2Connected);
            
            configurations = MMCIsing(initialConfiguration, parameters);
            
            % The initial configuration for the next temperature is the
            % final configuration of the previous temperature
            initialConfiguration = configurations(:,:,end);
            
            parameters = rmfield(parameters, 'neighborFunction');
            
            experiments(idx).parameters = parameters;
            
            U = computeAverageEnergy(configurations);
            C = computeSpecificHeat(configurations, parameters.temperature);
            
            experiments(idx).statistics = struct('averageEnergy', U,...
                'specificHeat', C);
            idx = idx + 1;
        end
    end
end

%% Store the results
save('../results/1D.mat', 'experiments')