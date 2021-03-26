%% This is obviously a work in progress
% For clarity, I'm using the same terminology as the game manual found at
% https://www.ultraboardgames.com/azul/game-rules.php
% Colors use the following key:
% (1) Blue; (2) Yellow; (3) Red; (4) Black; (5) Snow   % ---- can we just
% use strings here? The numbers will get confusing fast between the two
% sections of the board.
clc
clear

wall = createWall();
floor = create_floor();

%Example setup of a patternLines
patternLines = zeros(5,5,2);
% patternLines(2,4:5,1) = 1;
% patternLines(2,4:5,2) = 2;

%Alternative example: board is full of color 2
% patternLines = ones(5,5,2);
% patternLines (:,:,2) = 2;

%Another Example: board has center column full
%  patternLines(:,3,2) = [3 2 1 5 4];
patternLines(1,:,2) = 3;
patternLines(2,:,2) = 2;
patternLines(3,:,2) = 1;
patternLines(4,:,2) = 5;
patternLines(5,:,2) = 4;
patternLines(:,:,1) = 1;
patternLines

%Done try brute force LOL
best_pL = patternLines;
bestScoreOut = 0;
bestWallOut = wall(:,:,1);
bestWalls = zeros(5,5,100);
wallsScore = zeros(1,100);

wallNum = 1;
tic
for i=1:5    
    patternLines(1,:,2) = i;
    for j=1:5
        patternLines(2,:,2) = j;
        for k=1:5
            patternLines(3,:,2) = k;
            for l=1:5
                patternLines(4,:,2) = l;
                for m=1:5                    
                    patternLines(5,:,2) = m;
                    temp_pL = patternLines;
                    [wallOut, ~, scoreOut] = slideTiles(wall, patternLines, floor);
                    if scoreOut >= bestScoreOut
                        
                        bestScoreOut = scoreOut;
                        best_pL = temp_pL;
                        bestWallOut = wallOut(:,:,1);    
                        wallsScore(wallNum) = scoreOut;
                        bestWalls(:,:,wallNum) = wallOut(:,:,1);
                        wallNum = wallNum+1;
                                               
                    end
                end
            end
        end
    end
end
toc

%Get a list of only best walls.
k = 1;
for i=1:wallNum
    if (wallsScore(i) == max(wallsScore))
        topScoreWalls(:,:,k) = bestWalls(:,:,i);
        k = k+1;
    end   
end
%Add an empty one to the end for comparison in next part
topScoreWalls(:,:,length(topScoreWalls)+1) = zeros(5);
k = 1;

%Remove duplicates
for i=1:length(topScoreWalls)-1    
    if (topScoreWalls(:,:,i) == topScoreWalls(:,:,i+1))
        %Do nothing
    else
        topScoreWalls2(:,:,k) = topScoreWalls(:,:,i);
        k = k+1;
    end
end

%this is all of the combinations possible to get the highest possible score
%frequently just one board, sometimes multiple options.
topScoreWalls2
max(wallsScore)
    

%best_pL
bestWallOut;
bestScoreOut;

%[bestWallOut, newpatternLines, scoreOut] = slideTiles(wall, best_pL, floor)

%Slide some tiles.

%[wall, patternLines, scoreOut] = slideTiles(wall, patternLines, floor);
% 
% wall
% scoreOut


%% Function below this
function wall = createWall()
% This function creates a 5x5x2 wall/board
% wall(:,:,2) represents the colors. Uses default game board.
% wall(:,:,1) represents tiles placed on the wall. Starts empty.

wall = zeros(5,5,2);
%Set up the colors
for i=1:5
    for j=1:5
        wall(i,j,2) =j-i;
        %Fix the negative numbers so that we get a range 0-4
        if (wall(i,j,2) < 0)
            wall(i,j,2) = wall(i,j,2)+5;
        end
    end
end
wall(:,:,2) =wall(:,:,2) + 1; %add 1 to get range 1-5

%wall(:,:,1) = round(rand(5)-.2)*20 %for debugging
wall(3,:,1) = 10;
wall(2,5,1) = 10;
wall(2,4,1) = -10;
end

function floor = create_floor()
floor = zeros(1,7);
end

function [wall, patternLines, scoreOut] = slideTiles(wall, patternLines, floor)
%This function slides the tiles where rows of the patternLines were full
scoreOut = 0;
%Look at all the rows
for row=1:5
    %See if any complete rows of the patternLines are full    
    if(patternLines(row, (6-row):5,1) == 1)
        %If any complete rows full, slide them over
        [wall, patternLines, score1] = slideTilesColorCheck(wall,patternLines,row, floor);
        scoreOut = scoreOut+score1;
    end
end

end

function [wall, patternLines, score1] = slideTilesColorCheck(wall, patternLines, row, floor)
%Wall is the 5x5x2 board matrix where points are stored
%PatternLines is 5x5x2 where tiles are stored during a round
%Row is the row # of the triangle being checked.

%Look at the color of the triangle row under examination
rowColor = patternLines(row,5,2);
score1 = 0;
indexToChange = [];
%Scan through board and figure out where the appropriate color is
for i=1:5
    if(wall(row,i,2) == rowColor)
        %if the wall is already full, don't get points again
        if wall(row,i,1) ~= 0
            break
        end
        indexToChange = i;
        score1 = score1 + get_score(row, i, wall, floor, rowColor);
    end
end
%Update the board and wipe the triangle.
wall(row, indexToChange,1) = rowColor; %this was 1
patternLines(row,:,:) = 0;



end

function [score1] = get_score(row, column, wall, floor, color)
score1 = 1;
% Variables to keep track of how many tiles are filled within a row or
% column
cNumberFilled = 1;
rNumberFilled = 1;
% Check Rows for filled tiles adjacent to current tile
for index = row-1:-1:1 % Upper Rows
    if wall(index, column, 1) > 0
        score1 = score1 + 1;
        rNumberFilled = rNumberFilled + 1;
    elseif wall(index, column, 1) <= 0
        break
    end
    
end
for index = row+1:5 % Lower Rows
    if wall(index, column, 1) > 0
        score1 = score1 + 1;
        rNumberFilled = rNumberFilled + 1;
    elseif wall(index, column, 1) <= 0
        break
    end
    
end
% Check Columns for filled tiles adjacent to current tile
for index = column-1:-1:1 % Left Columns
    if wall(row, index, 1) > 0
        score1 = score1 + 1;
        cNumberFilled = cNumberFilled + 1;
    elseif wall(row, index, 1) <= 0
        break
    end
    
end
for index = column+1:5 % Right Colums
    if wall(row, index, 1) > 0
        score1 = score1 + 1;
        cNumberFilled = cNumberFilled + 1;
    elseif wall(row, index, 1) <= 0
        break
    end 
    
end
% Give Extra points for completing a row, column, or all of one color
if cNumberFilled == 5
    score1 = score1 + 2; %EDIT: this was 7, but row/cols were transposed
end
if rNumberFilled == 5
    score1 = score1 + 7; %EDIT: this was 7, but row/cols were transposed
end

%Give points for completing a color
edges = [1 2 3 4 5 6];
colorsNums = histcounts(wall(:,:,1),edges);

for i=1:5
    if(colorsNums(i) == 4)
        if (color == i)
            score1 = score1 + 10;
        end
    end
end

if sum(wall(:) == color) == 5
    
    %score1 = score1 + 10; %EDIT: this has issues
end
% Take Points for tiles on the floor
if row == 5
    for index = 1:7
        if floor(index) == 0
            break
        else
            if index == 1 | index == 2
                score1 = score1 - 1;
            elseif index == 3 | index == 4 | index == 5
                score1 = score1 - 2;
            elseif index == 6 | index == 7
                score1 = score1 - 3;
            end
        end
    end
end
end
