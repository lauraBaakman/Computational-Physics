function [ figure ] = specificHeat ( experiments, numberOfSampleIterations, varargin)
ns, varargin )
%SPECIFICHEAT1D Generate the Plotly handles for the C/N plots.
%   Plots U/N as a function of T for different values of N, i.e. number of
%   samples.

    parser = inputParser;
    parser.addRequired('experiments');
    parser.addRequired('numberOfSampleIterations');
    parser.addParameter('numParticles', [10, 100, 1000]);
    parser.parse(experiments, numberOfSampleIterations, varargin{:});

    subset = filterExperiments(experiments, 'numSampleIterations', numberOfSampleIterations);

    for i = 1:length(parser.Results.numParticles)
        N = parser.Results.numParticles(i);
        
       subsubset = filterExperiments(subset, 'numParticles', N); 
       statistics = [subsubset.statistics];
       parameters = [subsubset.parameters];
       
       specificHeatPerSpin = [statistics.specificHeat]./N;
       temperatures = [parameters.temperature];
       
        traces{i} = struct(...
          'x', temperatures, ...
          'y', specificHeatPerSpin, ...
          'name', sprintf('N = %d', N), ...
          'mode', 'lines' ,...
          'type', 'scatter');
    end
    
    layout = struct(...
        'xaxis', struct('title', '$T$', 'autotick', false, 'tick0', 0, 'dtick', 0.2),...
        'yaxis', struct('title', '$\frac{C}{N_\textit{samples}}$'));
    
    figure.data = traces;
    figure.layout = layout;
    figure.UserData = struct('filename', 'latex', 'fileopt', 'overwrite');    
    
end

