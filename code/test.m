clc; close all; clear all; 
rng('default');

computeNumRelaxIterations = @(n) 1/10 .* n;



%% Init 
temperature = 2;
numParticles = 5;
numSampleIterations = 3;
numRelaxIterations = 0;

parameters = struct(...
    'temperature', temperature,...
    'numParticles', numParticles,...
    'numSampleIterations', numSampleIterations,...
    'numRelaxIterations', numRelaxIterations,...
    'neighborFunction', @neighbors.OneD2Connected);

initial_configuration = generateRandomConfiguration([1, numParticles]);
configurations = MMCIsing(initial_configuration, parameters);

computeAverageEnergy(configurations);
computeSpecificHeat(configurations, temperature);