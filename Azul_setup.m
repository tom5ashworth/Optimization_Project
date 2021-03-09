clear;
close all;
clc;

% Index places (columns) from left to right equal 
% Red, Yellow, Blue, White, Black

%Intiate Factories and supply tiles
Factories = zeros(5,5);
Factories(1,:) = [1 0 2 1 0];
Factories(2,:) = [0 1 1 1 1];
Factories(3,:) = [2 0 2 0 0];
Factories(4,:) = [0 3 0 0 1];
Factories(5,:) = [0 1 0 1 2];

% Initiate center
Center = [2 4 1 1 0];

% 1st number in selection array corresponds to factory number (if 6,
% refers to the center) and 2nd number corresponds to a tile color
selection = [6 2];

[factories, center] = factory(selection, Factories, Center);

disp(factories);
disp(center);