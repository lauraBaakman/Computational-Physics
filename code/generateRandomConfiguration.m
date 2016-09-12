function [ configuration ] = generateRandomConfiguration( configurationSize )
%GENERATERANDOMCONFIGURATION Generate a random configuation of particles.
%   Particles are either positive (+1) or negative (-1). Size is an array
%   with the size of each dimension of the configuration.

configuration = round(rand(configurationSize));

% Map from [0, 1] to [-1, 1]
configuration = -1 + 2 * configuration;

end

