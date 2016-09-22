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
        
        actualNumSampleIterations = numSampleIterations * numParticles;
        numRelaxIterations = computeNumRelaxIterations(actualNumSampleIterations);
        
        initialConfiguration = ones([dimensionality, dimensionality]);
        
        for temperature = temperatures
            
            fprintf('2D: T = %1.1f N = %5d N_it = %9d\n', temperature, numParticles, actualNumSampleIterations);
            
%             parameters = struct(...
%                 'temperature', temperature,...
%                 'numParticles', numParticles,...
%                 'numSampleIterations', actualNumSampleIterations,...
%                 'numRelaxIterations', numRelaxIterations,...
%                 'neighborFunction', @neighbors.TwoD4Connected);
%             
%             % The initial configuration for the next temperature is the
%             % final configuration of the previous temperature
%             [energies , magnetizations, initialConfiguration] = MMCIsing(initialConfiguration, parameters);
%             
%             parameters = rmfield(parameters, 'neighborFunction');
%             
%             experiments(idx).parameters = parameters;
%             
%             U = mean(energies);
%             C = properties.specificHeat(temperature, energies);
%             M = mean(magnetizations);
%             
%             experiments(idx).statistics = struct(...
%                 'averageEnergy', U,...
%                 'specificHeat', C,...
%                 'averageMagnetization', M);
%             idx = idx + 1;
            
        end
    end
end

% %% Store the results
% save('../results/2D.mat', 'experiments')
% 
% %% Create plots
% output.plot(experiments, 'averageEnergy');
% output.plot(experiments, 'specificHeat');
% output.plot(experiments, 'averageMagnetization',...
%     'theoretical', @theory.averageMagnetizationPerSpin);