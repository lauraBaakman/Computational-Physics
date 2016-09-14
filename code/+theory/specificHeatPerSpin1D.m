function [ specificHeatPerSpin ] = specificHeatPerSpin1D( temperature )
%SPECIFICHEATPERSPIN1D Compute the theoretical specific heat per spin.

beta = 1 ./ temperature;

specificHeatPerSpin = (beta ./ cosh(beta) ).^2;

end

