function [ accuracy ] = computeAccuracy( actual, theory )
%ACCURACY Compute the accuracy of the ACTUAL values w.r.t. the value in THEORY.
accuracy = ones(size(actual)) - abs((abs(actual - theory) ./ actual));
end
