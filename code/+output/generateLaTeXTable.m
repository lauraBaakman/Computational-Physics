function [] = generateLaTeXTable( experiments, numSampleIterations, numParticles)
%GENERATELATEXTABLE Generate a LaTeX table for the experiments.
    data = output.collectData(experiments, numSampleIterations, numParticles);
    
    outputFile = generatePath(numSampleIterations, numParticles);
    
    fileID = fopen(outputFile,'w+');
    fprintf(fileID, '%%!TEX root = ../report.tex\n\n');
    fprintf(fileID, '\\num[round-precision=2]{%1.1f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num{%0.5f}\t& \\num[round-precision=2]{%0.5f}\t\\\\\n', data);
    fclose(fileID);
    
end

function [outputFilePath] = generatePath(numSampleIterations, numParticles)
    outputFilePath = sprintf('../report/tables/NS%d_N%d.tex', ...
        numSampleIterations, numParticles);
end