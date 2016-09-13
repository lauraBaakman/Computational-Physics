clc; close all; clear all; 
rng('default');

computeNumRelaxIterations = @(n) 1/10 .* n;

%% Init 
temperatures = 0.2:0.2:4;
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
          
          initial_configuration = generateRandomConfiguration([1, numParticles]);
          configurations = metropolisMonteCarloIsing(initial_configuration, parameters);
          
          parameters = rmfield(parameters, 'neighborFunction');
          
          experiments(idx).parameters = parameters;
          experiments(idx).configurations = configurations;
          idx = idx + 1;
      end
   end
end

%% Store the results
save('../results/1D.mat', 'experiments')


%% Compute requested data
