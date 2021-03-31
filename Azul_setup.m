clear;
close all;
clc;

% Intiate Factories with random tiles; index places (columns) are
% red, yellow, blue, white, black respectively
factories = zeros(5,5);
tiles = round(0.5+rand(1,20)*4.99);
k = 1;

for i = 1:5
    for j = 1:4
        factories(i,tiles(k)) =  factories(i,tiles(k))+1;
        k = k+1;
    end
end

% Initiate center
center = zeros(1,5);

% 1st number in selection corresponds to factory number (1-5 refer to
% a factory and 6 refers to the center)
% 2nd number corresponds to a tile color
selection = [1 4];

[factories, center] = factory_update(selection, factories, center);

factories
center