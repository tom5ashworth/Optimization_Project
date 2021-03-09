function [factories, center] = factory(selection, Factories, Center)
    if selection(1) < 6
        Factories(selection(1),selection(2)) = 0;
        Center = Center + Factories(selection(1),:);
        Factories(selection(1),:) = 0;
    else
        Center(1,selection(2)) = 0;
    end
    factories = Factories;
    center = Center;
end