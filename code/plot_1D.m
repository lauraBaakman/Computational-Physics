clc; close all; clear all; 
% load('../results/1D.mat');
load('../results/test1D.mat')

%% Average Energy for N_samples = 1000, T = 0.2:4, N = 10, 100, 1000
figure = plots.averageEnergy1D(experiments, 1000);
saveplotlyfig(figure, '~/Desktop/1DaverageEnergyN1000.png');