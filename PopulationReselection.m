function Population = PopulationReselection(Grid, GridIndex, N)
% Population reselection strategy of AGEA

%------------------------------- Copyright --------------------------------
% Copyright (c) 2024 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
    [~, M] = size(Grid.objs);
    D = pdist2(GridIndex, GridIndex, 'chebychev');
    D(D>1) = 0;
    crowding = sum(D, 2).^(1/M);
    fitness = crowding / max(max(crowding), 1e-10) * (N-1) + 1;
    Population = Grid(RouletteWheelSelection(N, fitness));   
end