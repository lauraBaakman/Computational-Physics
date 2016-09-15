function [ accuracy ] = computeAccuracy( actual, theory )
%ACCURACY Compute the accuracy.
accuracy = ones(size(actual)) - abs((abs(actual - theory) ./ actual));
end
