function [ average ] = averageMagnetizationPerSpin2D( temperatures)
%AVERAGEMAGNETIZATIONPERSPIN2D Theoretical average energy per spin.

T_c = 2 / log(1 + sqrt(2));
betas =  1 ./ temperatures;

magnetization = (temperatures < T_c) .* (ones(size(betas)) - sinh(2 .* betas).^(-4)).^2;
average = mean(magnetization);

end

