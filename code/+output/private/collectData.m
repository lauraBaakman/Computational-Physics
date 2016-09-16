function [data] = collectData(experiments, numSampleIterations, numParticles)
    subset = filterExperiments(experiments,...
        'numSampleIterations', numSampleIterations,...
        'numParticles', numParticles);

    parameters = [subset.parameters];
    statistics = [subset.statistics];

    temperature = [parameters.temperature];
    beta = 1 ./ temperature;

    UperSpin_MMC = [statistics.averageEnergy]./numParticles;
    CperSpin_MMC = [statistics.specificHeat]./numParticles;

    UperSpin_theory = theory.averageEnergyPerSpin1D(temperature);
    CperSpin_theory = theory.specificHeatPerSpin1D(temperature);
   
    accuracy = mean([...
       computeAccuracy(UperSpin_MMC, UperSpin_theory);...
       computeAccuracy(CperSpin_MMC, CperSpin_theory)]);
   
   data = [temperature; beta;...
       UperSpin_MMC; CperSpin_MMC;...
       UperSpin_theory; CperSpin_theory; accuracy];
end