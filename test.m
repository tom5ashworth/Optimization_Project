clear; clc;
newTiles = [[1.7917 1]
    [1.3283 2]
    [3.4228 3]
    [1.7682 4]
    [2.6658 5]];
%  score = continuous_score(newTiles)

 % ----------- options ----------------------------
    options = optimoptions('fmincon', ...
        'Algorithm', 'active-set', ...  % choose one of: 'interior-point', 'sqp', 'active-set', 'trust-region-reflective'
        'Display', 'iter-detailed', ...  % display more information
        'MaxIterations', 1000, ...  % maximum number of iterations
        'MaxFunctionEvaluations', 10000, ...  % maximum number of function calls
        'OptimalityTolerance', 1e-6, ...  % convergence tolerance on first order optimality
        'ConstraintTolerance', 1e-6 ...  % convergence tolerance on constraints
        );
    % -------------------------------------------
    lowerBound = ones(2,length(newTiles));
    upperBound = 5*ones(2,length(newTiles));

[xStar, fStar] = fmincon(@continuous, newTiles,...
        [],[],[],[], lowerBound, upperBound, [], options);
fStar = -fStar

function [score] = continuous(newTiles)
wall = [[2.6924    3.1248]
    [3.6223    1.4353]
    [3.8917    3.5271]
    [1.234 4.7]];
score = 0;
for tileIndex = 1:length(newTiles)
   for wallIndex = 1:length(wall)
      xDistance = (newTiles(tileIndex,1)-wall(wallIndex,1)); 
      yDistance = (newTiles(tileIndex,2)-wall(wallIndex,2));
      distance = sqrt(xDistance^2 + yDistance^2);
      f = ((distance-0.3)*(distance-3.5)*(distance-5))/10;
      colorPenalty = 0.5*cos(newTiles(tileIndex,1)*pi).^2 + 0.5*cos(newTiles(tileIndex,2)*pi).^2;
      f = f*colorPenalty;
      score = score + f;
   end
   wall(end+1,:) = newTiles(tileIndex,:);
end

score = -score;
end

