function [mean_accuracy] = generateLaTeXTable( experiments, numSampleIterations, numParticles, numIterations)
%GENERATELATEXTABLE Generate a LaTeX table for the experiments.
    data = collectData(experiments, numSampleIterations, numParticles);
    
    mean_accuracy = meanAccuracy(data);
    
    outputFile = generatePath(numIterations, numParticles);
    
    fileID = fopen(outputFile,'w+');
    fprintf(fileID, '%%!TEX root = ../report.tex\n\n');
    fprintf(fileID, '%1.1f\t& %0.5f\t& %0.5f\t& %0.5f\t& %0.5f\t& %0.5f\t& %0.5f\t\\\\\n', data);
    fclose(fileID);
    
end

function [outputFilePath] = generatePath(numIterations, numParticles)
    outputFilePath = sprintf('../report/tables/NS%d_N%d.tex', ...
        numIterations, numParticles);
end

function [average] = meanAccuracy(data)
    accuracies = data(end, :);
    average = mean(accuracies(~isinf(accuracies)));
end