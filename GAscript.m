clear; clc; close all;

% set options for multi-objective GA
o = gaoptimset('PopulationSize',128,'Vectorized', 'on','PlotFcns',@plotSurf,'Display','iter');

% specify min and max values for agent parameters:
% 1) network size, 
% 2) memory depth, and 
% 3) sensor fail rate

lb = [1,10,0];
ub = [50,10000,0.2];

[x,f] = gamultiobj(@fitnessFunction,3,[],[],[],[],lb,ub,o);


