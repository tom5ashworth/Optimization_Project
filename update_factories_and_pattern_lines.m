% selection = [factory, color, pattern line]
% color = (1) Blue; (2) Yellow; (3) Red; (4) Black; (5) Snow

function [factories, center, patternLines] = ...
update_factories_and_pattern_lines(selection, factories, center, patternLines)
    
    color = selection(2);
    
    if selection(1) < 6
        quantity = factories(selection(1),selection(2));
    else
        quantity = center(selection(2));
    end
    
    i = 0;
    j = 0;
    
    for k = 1:5
        if selection(3) == k
            while i < quantity && j < k
                if patternLines(k,5-j,1) == 0
                    patternLines(k,5-j,1) = 1;
                    patternLines(k,5-j,2) = color;
                    i = i + 1;
                end
                j = j + 1;
            end
            i = 0;
            j = 0;
        end
    end
    
    if selection(1) < 6
        
    %delete selected tiles from factory
    factories(selection(1),selection(2)) = 0;
    
    %set center to include leftover tiles and delete tiles from factory
    center = center + factories(selection(1),:);
    factories(selection(1),:) = 0;
        
    else
        center(1,selection(2)) = 0;
    end
end