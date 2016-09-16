function [figure] = plot( experiments, statistic, varargin)
%PLOT the parameter per spin as a function of temperature. 
    parser = inputParser;
    parser.addRequired('experiments');
    parser.addRequired('statistic');
    addParameter(parser, 'theoretical', nan);
    parser.parse(experiments, statistic, varargin{:});
    
    parameters = [experiments.parameters];
    
    numParticlesList = unique([parameters.numParticles]);
    numSampleIterationsList = unique([parameters.numSampleIterations]);

    i = 1;
    for numParticles = numParticlesList
        for numSampleIterations = numSampleIterationsList
            traces{i} = createPlotStruct(experiments, statistic, numParticles, numSampleIterations);
            i = i + 1;
        end
    end

    if isa(parser.Results.theoretical, 'function_handle')
        traces{i} = createTheoreticalPlotStruct(parameters, numParticles, parser.Results.theoretical);
    end    
    
    figure = createPlot(traces, statistic);
    writePlot(figure, statistic);
end

function [] = writePlot(figure, statistic)
    outputFile = sprintf('../report/img/2D/%s.pdf', statistic); 
    saveplotlyfig(figure, outputFile); 
end

function [figure] = createPlot(traces, statistic)
    yLabel = createYLabel(statistic);
    layout = struct(...
        'legend', struct(...
            'orientation', 'h'),...
        'font', struct('size', 18),...
        'xaxis', struct(...
            'title', '$T$',...
            'autotick', false, ...
            'tick0', 0,...
            'dtick', 0.4,...
            'tickangle', 0),...
        'yaxis', struct(...
            'title', yLabel)...
        );
    figure.data = traces;
    figure.layout = layout;
    figure.UserData = struct(...
        'filename', 'latex',...
        'fileopt', 'overwrite');    
    figure.UserData = struct('filename', 'latex', 'fileopt', 'overwrite');
end

function [yLabel] = createYLabel(statistic)
    if strcmp(statistic, 'averageEnergy')
        statisticStr = 'U';
    elseif strcmp(statistic,'specificHeat')
        statisticStr = 'C';
    elseif strcmp(statistic, 'averageMagnetization')
        statisticStr = 'M';
    end
    yLabel= sprintf('$\\frac{%s}{N}$', statisticStr);
end

function [trace] = createPlotStruct(experiments, statistic, numParticles, numSampleIterations)
    [temperatures, dependent] = getData(experiments, statistic, numParticles, numSampleIterations);
    dimensionality = sqrt(numParticles);
    trace = struct(...
          'x', temperatures, ...
          'y', dependent, ...
          'name', sprintf('$d = %03d, N_\\textit{samples} = %1.0g$', dimensionality, numSampleIterations), ...
          'mode', 'lines+marker' ,...
          'type', 'scatter');
end

function [trace] = createTheoreticalPlotStruct(parameters, numParticles, theoretical)
    temperatures = unique([parameters.temperature]);
    dependent = theoretical(temperatures);
    dimensionality = sqrt(numParticles);
    trace = struct(...
          'x', temperatures, ...
          'y', dependent, ...
          'name', sprintf('theoretical'), ...
          'mode', 'lines+marker' ,...
          'type', 'scatter',...
          'line', struct(...
                'dash', 'dashdot',...
                'width', 2)...
            );
end

function [temperatures, dependent] = getData(experiments, statistic, numParticles, numSampleIterations)
    subset = filterExperiments(experiments,...
        'numParticles', numParticles,...
        'numSampleIterations', numSampleIterations...
    );

    dependent = getStatistic(subset, statistic) ./ numParticles;
    temperatures = getTemperatures(subset);
end

function [dependent] = getStatistic(subset, statistic)
    statistics = [subset.statistics];
    dependent = nan(1, length(statistics));
    for i = 1:length(statistics)
        dependent(i) = getfield(statistics(i), statistic);
    end
end

function [temperatures] = getTemperatures(subset)
    parameters = [subset.parameters];
    temperatures = [parameters.temperature];
end
