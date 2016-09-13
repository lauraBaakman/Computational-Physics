function [ energy ] = energy( configuration )
%ENERGY Compute the energy of a configuration

    if isvector(configuration)
        energy = energy1D(configuration);
    elseif ismatrix(configuration)
        energy = energy2D(configuation);
    else
        error('Error. \nEnergy computation is not supported for %d-dimensional configurations.',length(size(configuration)));
    end

end

function [energy] = energy1D(configuration)
    error('Error. \nNot yet implemented.')
end

function [energy] = energy2D(configuration)
    error('Error. \nNot yet implemented.')
end
