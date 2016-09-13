function [ ] = filterConfigurations( configurations, varargin )
%FILTERCONFIGURATIONS Summary of this function goes here
%   Detailed explanation goes here

parser = inputParser;
parser.addRequired('configurations');
addParameter(parser, 'temperature', nan, @isnumeric);
addParameter(parser, 'numParticles', nan, @isnumeric);
addParameter(parser, 'numSampleIterations', nan, @isnumeric);
addParameter(parser, 'numRelaxIterations', nan, @isnumeric);


parser.parse(configurations, varargin{:});

parser.Results
sprintf('Configurations: %d', configurations);


end

