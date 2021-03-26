clear all; clc
newTiles = [[1 5]
    [2 4]
    [1 3]
    [1 2]
    [1 1.4]];

%h = get_score(newTiles, wall);

lb = ones(1,10);
ub = lb*5;
[xStar fStar, flag, output] = particleswarm(@get_score, 10, lb, ub)

xStarFixed(:,1) = xStar(1:5);
xStarFixed(:,2) = xStar(6:10);
xStarFixed

function [score1] = get_score(input1)
wall = [[2 3]
    [3 1]
    [4 4]
    [1 4]];

score1 = 0;
newTiles(:,1) = input1(1:5);
newTiles(:,2) = input1(6:10);

for newTileIndex = 1:5
    % Variables to keep track of how many tiles are filled within a row or
    % column
    cNumberFilled = 1;
    rNumberFilled = 1;
    xVal = round(newTiles(newTileIndex,1));
    yVal = round(newTiles(newTileIndex,2));
    
    for i = 1:length(wall)
        if (wall(i,1) == xVal) && (wall(i,2) == yVal)
            score1 = score1 - 500;
        end
    end
    
    % Check Rows for filled tiles adjacent to current tile
    for index = 1:length(wall) % Upper Rows
        if (wall(index,1) == xVal + 1) && (wall(index,2) == yVal)
            score1 = score1 + 1;
            rNumberFilled = rNumberFilled + 1;
            for index2 = 1:length(wall)
                if (wall(index2,1) == xVal + 2) && (wall(index2,2) == yVal)
                    score1 = score1 + 1;
                    rNumberFilled = rNumberFilled + 1;
                    for index3 = 1:length(wall)
                        if (wall(index3,1) == xVal + 3) && (wall(index3,2) == yVal)
                            score1 = score1 + 1;
                            rNumberFilled = rNumberFilled + 1;
                            for index4 = 1:length(wall)
                                if (wall(index4,1) == xVal + 4) && (wall(index4,2) == yVal)
                                    score1 = score1 + 1;
                                    rNumberFilled = rNumberFilled + 1;
                                end
                            end
                        end
                    end
                end
            end
        end
        if (wall(index,1) == xVal - 1) && (wall(index,2) == yVal)
            score1 = score1 + 1;
            rNumberFilled = rNumberFilled + 1;
            for index2 = 1:length(wall)
                if (wall(index2,1) == xVal - 2) && (wall(index2,2) == yVal)
                    score1 = score1 + 1;
                    rNumberFilled = rNumberFilled + 1;
                    for index3 = 1:length(wall)
                        if (wall(index3,1) == xVal - 3) && (wall(index3,2) == yVal)
                            score1 = score1 + 1;
                            rNumberFilled = rNumberFilled + 1;
                            for index4 = 1:length(wall)
                                if (wall(index4,1) == xVal - 4) && (wall(index4,2) == yVal)
                                    score1 = score1 + 1;
                                    rNumberFilled = rNumberFilled + 1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    for index = 1:length(wall) % Upper Rows
        if (wall(index,2) == yVal + 1) && (wall(index,1) == xVal)
            score1 = score1 + 1;
            cNumberFilled = cNumberFilled + 1;
            for index2 = 1:length(wall)
                if (wall(index2,2) == yVal + 2) && (wall(index2,1) == xVal)
                    score1 = score1 + 1;
                    cNumberFilled = cNumberFilled + 1;
                    for index3 = 1:length(wall)
                        if (wall(index3,2) == yVal + 3) && (wall(index3,1) == xVal)
                            score1 = score1 + 1;
                            cNumberFilled = cNumberFilled + 1;
                            for index4 = 1:length(wall)
                                if (wall(index4,2) == yVal + 4) && (wall(index4,1) == xVal)
                                    score1 = score1 + 1;
                                    cNumberFilled = cNumberFilled + 1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    for index = 1:length(wall) % Upper Rows
        if (wall(index,2) == yVal - 1) && (wall(index,1) == xVal)
            score1 = score1 + 1;
            cNumberFilled = cNumberFilled + 1;
            for index2 = 1:length(wall)
                if (wall(index2,2) == yVal - 2) && (wall(index2,1) == xVal)
                    score1 = score1 + 1;
                    cNumberFilled = cNumberFilled + 1;
                    for index3 = 1:length(wall)
                        if (wall(index3,2) == yVal - 3) && (wall(index3,1) == xVal)
                            score1 = score1 + 1;
                            cNumberFilled = cNumberFilled + 1;
                            for index4 = 1:length(wall)
                                if (wall(index4,2) == yVal - 4) && (wall(index4,1) == xVal)
                                    score1 = score1 + 1;
                                    cNumberFilled = cNumberFilled + 1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    
    %No neighbors, get a pity point
    if (rNumberFilled == 1 && cNumberFilled == 1)
        score1 = score1+1;
    end
    
    %If row neighbors, then get a point for being in rows
    if (rNumberFilled > 1)
        score1 = score1+1;
    end
    
    if (cNumberFilled > 1)
        score1 = score1+1;
    end
    
    
    if rNumberFilled == 5
        score1 = score1 + 2; %EDIT: this was 7, but row/cols were transposed
    end
    if cNumberFilled == 5
        score1 = score1 + 7; %EDIT: this was 7, but row/cols were transposed
    end
    
    
    wall(end+1,:) = [xVal yVal];
    
    
    
end

% Give Extra points for completing a row, column, or all of one color


%Give points for completing a color
%     edges = [1 2 3 4 5 6];
%     colorsNums = histcounts(wall(:,:,1),edges);

%     for i=1:5
%         if(colorsNums(i) == 4)
%             if (color == i)
%                 score1 = score1 + 10;
%             end
%         end
%     end

%     if sum(wall(:) == color) == 5
%
%         %score1 = score1 + 10; %EDIT: this has issues
%     end
%     % Take Points for tiles on the floor
%     if row == 5
%         for index = 1:7
%             if floor(index) == 0
%                 break
%             else
%                 if index == 1 | index == 2
%                     score1 = score1 - 1;
%                 elseif index == 3 | index == 4 | index == 5
%                     score1 = score1 - 2;
%                 elseif index == 6 | index == 7
%                     score1 = score1 - 3;
%                 end
%             end
%         end
%     end
score1 = -score1;
end
