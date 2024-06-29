function [Grid, gmax] = GridStabilization(Grid, zmin, gmax, div, N)
% Update the grid nadir point of AGEA

%------------------------------- Copyright --------------------------------
% Copyright (c) 2024 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
    [FrontNo, ~] = NDSort(roundn(Grid.objs, -10), N);
    NDPop = Grid(FrontNo == 1);
    Grid = Grid(FrontNo ~= inf);
    [~, M] = size(NDPop.objs);
    zmax = max(max(NDPop.objs, [], 1), zmin + 1e-10);
    side_length = (gmax - zmin) / (div - 1);
    for i = 1: M
        if abs(zmax(i) - gmax(i)) > 0.5*side_length(i)
            gmax(i) = zmax(i);
        end
    end       
end