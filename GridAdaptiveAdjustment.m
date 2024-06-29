function [Grid, GridIndex, div] = GridAdaptiveAdjustment(Grid, zmin, gmax, div, N) 
% Update the grid and divisions number of AGEA

%------------------------------- Copyright --------------------------------
% Copyright (c) 2024 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
    [NewGrid, GridIndex] = EnvironmentalSelection_AGEA(Grid, zmin, gmax, div); 
    if length(NewGrid) > N && div > 2
        div = div - 1;
        [NewGrid2, GridIndex2] = EnvironmentalSelection_AGEA(Grid, zmin, gmax, div);
        if length(NewGrid2) >= N
            Grid = NewGrid2;
            GridIndex = GridIndex2;  
        else
            Grid = NewGrid;
            div = div + 1;
        end
    else
        Grid = NewGrid;
        if length(NewGrid) < N && div < 200
            div = div + 1;
        end
    end
end