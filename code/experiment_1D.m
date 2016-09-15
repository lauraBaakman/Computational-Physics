clc; close all; clear all; 
rng('default');

computeNumRelaxIterations = @(n) 1/10 .* n;

%% Init 
% temperatures = 0.2:0.2:4;
temperatures = 0.2:1:4;
numParticlesList = [10, 100, 1000];
numSampleIterationsList = [1000, 10000];

idx = 1;

%% Run Simulations
for temperature = temperatures
   for numParticles = numParticlesList
      for numSampleIterations =  numSampleIterationsList
          numRelaxIterations = computeNumRelaxIterations(numSampleIterations);
          
          parameters = struct(...
            'temperature', temperature,...
            'numParticles', numParticles,...
            'numSampleIterations', numSampleIterations,...
            'numRelaxIterations', numRelaxIterations,...
            'neighborFunction', @neighbors.OneD2Connected);
          
          modelSize = [1, numParticles];
          configurations = MMCIsing(modelSize, parameters);
          
          parameters = rmfield(parameters, 'neighborFunction');
          
          experiments(idx).parameters = parameters;
          experiments(idx).configurations = configurations;
          
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