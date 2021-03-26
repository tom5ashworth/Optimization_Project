function [factories, center] = factory_update(selection, factories, center)
    if selection(1) < 6
        factories(selection(1),selection(2)) = 0;
        center = center + factories(selection(1),:);
        factories(selection(1),:) = 0;
    else
        center(1,selection(2)) = 0;
    end
end