clear;
close all;
clc;

% Index places (columns) are red, yellow, blue, white, black respectively

%Intiate Factories and supply tiles
factories = [[1 0 2 1 0]
    [0 1 1 1 1]
    [2 0 2 0 0]
    [0 3 0 0 1]
    [0 1 0 1 2]];

% Initiate center
center = zeros(1,5);

% 1st number in selection array corresponds to factory number (1-5 refer to
% a factory and 6 refers to the center) and 2nd number corresponds to a
% tile color
selection = [1 4];

[factories, center] = factory_update(selection, factories, center);

factories
center