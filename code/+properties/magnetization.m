function [ magnetizations ] = magnetization( configurations )
%MAGNETIZATION Compute the magnetization of a (list of) configuration(s).

magnetizations = sum(sum(configurations, 1), 2);

end

