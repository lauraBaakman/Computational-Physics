clc; close all; clear all; 
rng('default');

computeNumRelaxIterations = @(n) 1/10 .* n;

%% Init 
temperatures = 0.2:0.2:4;
dimensionalityList = [10, 50, 100];
numSampleIterationsList = [1000, 10000];

idx = 1;

%% Run Simulations
for dimensionality = dimensionalityList
    numParticles = dimensionality * dimensionality;
    
    for numSampleIterations =  numSampleIterationsList
        numRelaxIterations = computeNumRelaxIterations(numSampleIterations);
        initialConfiguration = ones([dimensionality, dimensionality]);
        
        for temperature = temperatures
          
          parameters = struct(...
            'temperature', temperature,...
            'numParticles', numParticles,...
            'numSampleIterations', numSampleIterations,...
            'numRelaxIterations', numRelaxIterations,...
            'neighborFunction', @neighbors.TwoD4Connected);
          
          configurations = MMCIsing(initialConfiguration, parameters);

          % The initial configuration for the next temperature is the
          % final configuration of the previous temperature
          initialConfiguration = configurations(:,:,end);
          
          parameters = rmfield(parameters, 'neighborFunction');
          
          experiments(idx).parameters = parameters;
          experiments(idx).configurations = configurations;
          
          U = computeAverageEnergy(configurations);
          C = computeSpecificHeat(configurations, parameters.temperature);
          M = computeAverageMagnetization(configurations);
          
          experiments(idx).statistics = struct(...
              'averageEnergy', U,...
              'specificHeat', C,...
              'averageMagnetization', M);
          idx = idx + 1;
        end
    end
end

%% Store the results
save('../results/2D.mat', 'experiments')