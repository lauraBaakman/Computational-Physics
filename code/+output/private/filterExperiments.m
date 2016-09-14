function [ subset ] = filterExperiments( experiments, varargin )
%FILTERCONFIGURATIONS Filter configurations on different parameters.

    parser = inputParser;
    parser.addRequired('experiments');
    addParameter(parser, 'temperature', nan, @isnumeric);
    addParameter(parser, 'numParticles', nan, @isnumeric);
    addParameter(parser, 'numSampleIterations', nan, @isnumeric);
    addParameter(parser, 'numRelaxIterations', nan, @isnumeric);

    parser.parse(experiments, varargin{:});

    subset = experiments;
    
    if ~ isnan(parser.Results.temperature)
        parameters = [subset.parameters];
        subset = subset([parameters.temperature] == parser.Results.temperature);
    end

    if ~ isnan(parser.Results.numParticles)
        parameters = [subset.parameters];
        subset = subset([parameters.numParticles] == parser.Results.numParticles);
    end

    if ~ isnan(parser.Results.numSampleIterations)
        parameters = [subset.parameters];
        subset = subset([parameters.numSampleIterations] == parser.Results.numSampleIterations);
    end    
    
    if ~ isnan(parser.Results.numRelaxIterations)
        parameters = [subset.parameters];
        subset = subset([parameters.numRelaxIterations] == parser.Results.numRelaxIterations);
    end        

end

