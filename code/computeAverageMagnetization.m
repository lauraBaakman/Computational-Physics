function [ average ] = computeAverageMagnetization( configurations )
    magnetizations = sum(sum(configurations, 1), 2);
    average= mean(magnetizations);
end