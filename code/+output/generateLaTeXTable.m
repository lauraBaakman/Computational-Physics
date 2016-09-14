function [] = generateLaTeXTable( experiments, numSampleIterations, numParticles)
%GENERATELATEXTABLE Generate a LaTeX table for the experiments.
    data = collectData(experiments, numSampleIterations, numParticles);
    
    outputFile = generateOutputFilePath(numSampleIterations, numParticles);
    
%     sprintf('\\num[round-precision=2]{%1.1f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num[round-precision=2]{%0.5f}\t\\\\\n', data)
    
    fileID = fopen(outputFile,'w+');
    fprintf(fileID, '%%!TEX root = ../report.tex\n\n');
    fprintf(fileID, '\\num[round-precision=2]{%1.1f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num[round-precision=2]{%0.5f}\t\\\\\n', data);
    fclose(fileID);
    
end

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

function [outputFilePath] = generateOutputFilePath(numSampleIterations, numParticles)
    outputFilePath = sprintf('../report/tables/NS%d_N%d.tex', numSampleIterations, numParticles);
end