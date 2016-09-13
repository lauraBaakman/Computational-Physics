clc; close all; clear all; 
load('../results/1D.mat');

%% Average Energy for N_samples = 1000, T = 0.2:4, N = 10, 100, 1000
figure = plots.averageEnergy1D(experiments, 1000);
saveplotlyfig(figure, '../report/img/1D/1DaverageEnergyN1000.pdf');

%% Average Energy for N_samples = 10000, T = 0.2:4, N = 10, 100, 1000
figure = plots.averageEnergy1D(experiments, 10000);
saveplotlyfig(figure, '../report/img/1D/1DaverageEnergyN10000.pdf');

%% Sepcific Heat for N_samples = 1000, T = 0.2:4, N = 10, 100, 1000
figure = plots.averageEnergy1D(experiments, 1000);
saveplotlyfig(figure, '../report/img/1D/1DspecificHeatN1000.pdf');

%% Sepcific Heat for N_samples = 10000, T = 0.2:4, N = 10, 100, 1000
figure = plots.averageEnergy1D(experiments, 10000);
saveplotlyfig(figure, '../report/img/1D/1DspecificHeatN10000.pdf');