clc; close all; clear variables; 
rng('default');

computeNumRelaxIterations = @(n) 1/10 .* n;

%% Init 
temperatures = 0.2:0.2:0.4;
numParticles = 100;
numIterations = 10000;

numSampleIterations = numIterations * numParticles;
numRelaxIterations = computeNumRelaxIterations(numSampleIterations);

configuration = ones([1, numParticles]);

for temperature = temperatures
    parameters = struct(...
        'temperature', temperature,...
        'numParticles', numParticles,...
        'numSampleIterations', numSampleIterations,...
        'numRelaxIterations', numRelaxIterations);

    [configuration, energies , magnetizations] = MMCIsing(configuration, parameters);
end

U = mean(energies);
actual = U / numParticles;
expected = theory.averageEnergyPerSpin1D(temperature);

fprintf('U per spin should be: %1.3f, it is %1.3f, accuracy %1.3f\n', expected, actual, computeAccuracy(actual, expected));
beep; beep;