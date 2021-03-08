%% This is obviously a work in progress
% For clarity, I'm using the same terminology as the game manual found at
% https://www.ultraboardgames.com/azul/game-rules.php
% Colors use the following key:
% (1) Blue; (2) Yellow; (3) Red; (4) Black; (5) Snow   % ---- can we just
% use strings here? The numbers will get confusing fast between the two
% sections of the board.
clc
clear

%Example setup of a patternLines
patternLines = zeros(5,5,2);
patternLines(2,4:5,1) = 1;
patternLines(2,4:5,2) = 2;

%Alternative example: board is full of color 2
%patternLines = ones(5,5,2);
%patternLines (:,:,2) = 2;

patternLines

%Slide some tiles.
wall = createWall();
[wall, patternLines] = slideTiles(wall, patternLines);

wall


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
end

function floor = create_floor()
    floor = zeros(1,7);
end

function [wall patternLines] = slideTiles(wall, patternLines)
%This function slides the tiles where rows of the patternLines were full

%Look at all the rows
for row=1:5
    %See if any complete rows of the patternLines are full
    if(patternLines(row, (6-row):5,1) == 1)
        %If any complete rows full, slide them over
        [wall patternLines] = slideTilesColorCheck(wall,patternLines,row);
    end
end

end

function [wall, patternLines] = slideTilesColorCheck(wall, patternLines, row)
%Wall is the 5x5x2 board matrix where points are stored
%PatternLines is 5x5x2 where tiles are stored during a round
%Row is the row # of the triangle being checked.

%Look at the color of the triangle row under examination
rowColor = patternLines(row,5,2);

indexToChange = [];
%Scan through board and figure out where the appropriate color is
for i=1:5
    if(wall(row,i,2) == rowColor)
        indexToChange = i;
        score = score + get_score(row, i, wall, floor, rowColor);
    end
end
%Update the board and wipe the triangle.
wall(row, indexToChange,1) = 1;
patternLines(row,:,:) = 0;



end

function [score] = get_score(row, column, wall, floor, color)
score = 1;
% Variables to keep track of how many tiles are filled within a row or
% column
cNumberFilled = 1;
rNumberFilled = 1;
% Check Rows for filled tiles adjacent to current tile
for index = row-1:-1:1 % Upper Rows
    if wall(index, column, 1) == 1
        score = score + 1;
        rNumberFilled = rNumberFilled + 1;
    elseif wall(index, column, 1) == 0
        break
    end
    
end
for index = row+1:5 % Lower Rows
    if wall(index, column, 1) == 1
        score = score + 1;
        rNumberFilled = rNumberFilled + 1;
    elseif wall(index, column, 1) == 0
        break
    end
    
end
% Check Columns for filled tiles adjacent to current tile
for index = column-1:-1:1 % Left Columns
    if wall(row, index, 1) == 1
        score = score + 1;
        cNumberFilled = cNumberFilled + 1;
    elseif wall(row, index, 1) == 0
        break
    end
    
end
for index = column+1:5 % Right Colums
    if wall(row, index, 1) == 1
        score = score + 1;
        cNumberFilled = cNumberFilled + 1;
    elseif wall(row, index, 1) == 0
        break
    end
    
end
% Give Extra points for compleating a row, column, or all of one color
if cNumberFilled == 5
    score = score + 7;
end
if rNumberFilled == 5
    score = score + 2;
end
if sum(wall(:) == color) == 5
   score = score + 10; 
end
% Take Points for tiles on the floor
for index = 1:7
   if floor(index) == 0
       break
   else
      if index == 1 | index == 2
          score = score - 1;
      elseif index == 3 | index == 4 | index == 5
          score = score - 2;
      elseif index == 6 | index == 7
          score = score - 3;
      end
   end 
end
end

