clc; close all; clear all; 
rng('default');

computeNumRelaxIterations = @(n) 1/10 .* n;



%% Init 
temperature = 2;
% numParticles = 5;
% numSampleIterations = 3;

numParticles = 10;
numSampleIterations = 10000;

numRelaxIterations = computeNumRelaxIterations(numSampleIterations);
actualNumSampleIterations = numSampleIterations * numParticles;

parameters = struct(...
    'temperature', temperature,...
    'numParticles', numParticles,...
    'numSampleIterations', actualNumSampleIterations,...
    'numRelaxIterations', numRelaxIterations);

initial_configuration = ones([numParticles, numParticles]);
configurations = MMCIsing(initial_configuration, parameters);

beep; beep;