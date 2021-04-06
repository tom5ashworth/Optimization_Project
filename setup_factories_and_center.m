function [factories, center] = setup_factories_and_center()
    
    % Intiate Factories with random tiles; index places (columns) are
    % (1) Blue; (2) Yellow; (3) Red; (4) Black; (5) Snow
    factories = zeros(5,5);
    tiles = round(0.5+rand(1,20)*4.99);
    k = 1;

    for i = 1:5
        for j = 1:4
            factories(i,tiles(k)) =  factories(i,tiles(k))+1;
            k = k+1;
        end
    end

    % Initiate center with no tiles
    center = zeros(1,5);
end