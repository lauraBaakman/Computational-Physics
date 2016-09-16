clc; close all; clear all; 
load('../results/1D.mat');

numParticlesList = [10, 100, 1000];
numSampleIterationsList = [1000, 10000];

   for numParticles = numParticlesList
      for numSampleIterations =  numSampleIterationsList
        accuracy = output.generateLaTeXTable(experiments, numSampleIterations, numParticles);          
        fprintf('%d %d %f\n', numParticles, numSampleIterations, accuracy)
      end
      fprintf('\n')
   end

