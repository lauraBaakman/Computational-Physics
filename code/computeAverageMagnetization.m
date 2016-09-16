function [ average ] = computeAverageMagnetization( configurations )
%COMPUTEAVERAGEMAGNETIZATION Compute average magnetization of a set of CONFIGURATIONS.
    magnetizations = sum(sum(configurations, 1), 2);
    average= mean(magnetizations);
end