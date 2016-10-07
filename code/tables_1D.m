clc; close all; clear all; 
load('../results/1D.mat');

numParticlesList = [10, 100, 1000];
numIterationsList = [1000, 10000];

accuracy = nan(length(numIterationsList), length(numParticlesList));

   for numParticles_idx = 1:length(numParticlesList)
      numParticles = numParticlesList(numParticles_idx);
      for numIterations_idx =  1:length(numIterationsList)
        numIterations = numIterationsList(numIterations_idx);
        
        numSampleIterations = numIterations * numParticles;
        accuracy = output.generateLaTeXTable(experiments, numSampleIterations, numParticles);          
        fprintf('%d %d %f\n', numParticles, numSampleIterations, accuracy)
        
      end
      fprintf('\n')
   end

