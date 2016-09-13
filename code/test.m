clc; close all; clear all; 
rng('default'); 

computeNumRelaxIterations = @(n) 0;

%% Init 
temperatures = 2;
numParticlesList = 5;
numSampleIterationsList = 3;

parameters = struct(...
    'temperature', 2,...
    'numParticles', 5,...
    'numSampleIterations', 3,...
    'numRelaxIterations', 0,...
    'neighborFunction', @neighbors.OneD2Connected);

initial_configuration = generateRandomConfiguration([1, parameters.numParticles]);
configurations = metropolisMonteCarloIsing(initial_configuration, parameters);