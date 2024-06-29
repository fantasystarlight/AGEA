classdef AGEA < ALGORITHM
% <multi> <real/binary/permutation>
% Adaptive grid based evolutionary algorithm
% kind --- 1 --- limit output solutions number no more than N (1. limit  0. no limit)
% div --- 10 --- initial number of grid divisions
    methods
        function main(Algorithm,Problem)
            %% Parameter setting
            [kind, div]= Algorithm.ParameterSet(1, 10);
            %% Generate random population
            Population = Problem.Initialization(); 
            Grid   = Population;  
            zmin = min(Population.objs,[],1);
            zmax = max(max(Population.objs, [], 1), zmin + 1e-10);
            gmax = zmax;            
            while Algorithm.NotTerminated(Grid)
            %% Optimization
                MatingPool = randperm(length(Population));
                Offspring = OperatorGA(Problem, Population(MatingPool));
                Grid = [Grid, Offspring];
                zmin = min(zmin, min(Grid.objs,[],1));                
                [Grid, gmax] = GridStabilization(Grid, zmin, gmax, div, Problem.N);               
                [Grid, GridIndex, div] = GridAdaptiveAdjustment(Grid, zmin, gmax, div, Problem.N);                  
                Population = PopulationReselection(Grid, GridIndex, Problem.N);     
              %% limit output solutions number to N               
                if Problem.FE >= Problem.maxFE
                    if kind ~= 0 && length(Grid) > Problem.N
                        Grid = EnvironmentalSelection_SPEA2(Grid, Problem.N);
                    end
                end
            end
        end
    end
end


