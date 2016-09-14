function [ averageEnergyPerSpin ] = averageEnergyPerSpin1D( temperature)
%AVERAGEENERGYPERSPIN Compute the theoretical average energy per spin.

beta = 1 ./ temperature;
averageEnergyPerSpin = -tanh(beta);
end

