clc; close all; clear all; 
load('../results/1D.mat');

numParticlesList = [10, 100, 1000];
numIterationsList = [1000, 10000];

accuracies = nan(length(numIterationsList), length(numParticlesList) + 1);

   for numParticles_idx = 1:length(numParticlesList)
      numParticles = numParticlesList(numParticles_idx);
      for numIterations_idx =  1:length(numIterationsList)
        numIterations = numIterationsList(numIterations_idx);
        
        numSampleIterations = numIterations * numParticles;
        accuracy = output.generateLaTeXTable(experiments, numSampleIterations, numParticles, numIterations);          
        accuracies(numIterations_idx, numParticles_idx + 1)  = accuracy;
        accuracies(numIterations_idx, 1) = numIterations;
      end
   end

outputFile = '../report/tables/accuracies_1D.tex';


%%
fileID = fopen(outputFile,'w+');
fprintf(fileID, '%%!TEX root = ../report.tex\n\n');
fprintf(fileID, '%7d \t& %8.5f\t& %8.5f\t& %16.5f\t\\\\\n', accuracies');
fclose(fileID);