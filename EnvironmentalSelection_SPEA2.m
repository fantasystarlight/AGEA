function Population = EnvironmentalSelection_SPEA2(Population, N)
% Population reselection strategy of SPEA2

%------------------------------- Copyright --------------------------------
% Copyright (c) 2024 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
    PopObj = Population.objs;
    [PopSize, ~] = size(Population.objs);
    zmin      = min(PopObj,[],1);
    zmax      = max(max(PopObj,[],1), zmin + 1e-10);   
    PopObj   = PopObj ./ (zmax - zmin); 
    Del = Truncation(PopObj, PopSize - N);
    Population = Population(~Del);
end

function Del = Truncation(PopObj,K)
% Select part of the solutions by truncation

    %% Truncation
    Distance = pdist2(PopObj,PopObj);
    Distance(logical(eye(length(Distance)))) = inf;
    Del = false(1,size(PopObj,1));
    while sum(Del) < K
        Remain   = find(~Del);
        Temp     = sort(Distance(Remain,Remain),2);
        [~,Rank] = sortrows(Temp);
        Del(Remain(Rank(1))) = true;
    end
end