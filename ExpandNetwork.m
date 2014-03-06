function [ nw2 ] = ExpandNetwork( nw1, new )
% Expands a network by adding the new nw to the bottom right
    if size(nw1) == 0
        nw2 = new;
    else
        [i,j] = size(new);
        [I,J] = size(nw1);
        nw2 = [[nw1,zeros(I,j)];[zeros(i,J),new]];
    end
end

