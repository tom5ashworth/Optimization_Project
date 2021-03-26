function [xDistance, yDistance] = get_distances(newTiles, tileIndex, wall, wallIndex)

xDistance = (newTiles(tileIndex,1)-wall(wallIndex,1));
if (0.8 <= abs(xDistance))&&(abs(xDistance) <= 1.2)
    xDistance = 1;
else
    xDistance = 0;
end
yDistance = (newTiles(tileIndex,2)-wall(wallIndex,2));
if (0.8 <= abs(yDistance))&&(abs(yDistance) <= 1.2)
    yDistance = 1;
else
    yDistance = 0;
    
end