clc; close all; clear all; 

computeNumRelaxIterations = @(n) 1/10 .* n;

%%init
temperatures = 0.2:0.2:4;
numParticlesList = [10, 100, 1000];
numSampleIterationsList = [1000, 10000];

for temperature = temperatures
   for numParticles = numParticlesList
      for numSampleIterations =  numSampleIterationsList
          numRelaxIterations = computeNumRelaxIterations(numSampleIterations);
          
          parameters = struct(...
            'temperature', temperature,...
            'numParticles', numParticles,...
            'numSampleIterations', numSampleIterations,...
            'numRelaxIterations', numRelaxIterations,...
            'beta', 1,...
            'neighbourFunction', neighbors.OneD2Connected);
          
          initial_configuration = generateRandomConfiguration([1, numParticles]);
          configurations = metropolisMonteCarloIsing(initial_configuration, parameters);
      end
   end
end
