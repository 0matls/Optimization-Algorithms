%%
% function to crossover the best genes this can happen in two ways
% 1. combine: take the first n chromosomes from the first parent and the
% remaining from the second. The cutpoint (that defines the n) is random
% (1 to lengthOfGenes-1)
% 2. mean: take the mean of the both parents for every chromosome
% respectively

%%
function crossoveredgenes = crossover(bestGenes, NumberOfCrossoveredGenes)
  %might change the way they crossover later 
   
    lengthOfGenes = size(bestGenes,2);
    crossoveredgenes = zeros(NumberOfCrossoveredGenes, lengthOfGenes);
    numberOfBestGenes = size(bestGenes,1);
    
    NumberOfCombinedCrossoveredGenes = 2 * ceil(NumberOfCrossoveredGenes/4);
      
    for i = 1 : 2 : NumberOfCombinedCrossoveredGenes
        
        k = randperm(numberOfBestGenes);
        
        parent1 = bestGenes(k(1), :);
        parent2 = bestGenes(k(1+1),:);

        cutPoint = randi(lengthOfGenes-1);

        child1 = [parent1(1:cutPoint) parent2(cutPoint+1:end)];
        child2 = [parent2(1:cutPoint) parent1(cutPoint+1:end)];

        crossoveredgenes(i:i+1, :) = [child1; child2];
    end

    for i = NumberOfCombinedCrossoveredGenes + 1 : NumberOfCrossoveredGenes
        k = randperm(numberOfBestGenes);
        crossoveredgenes(i, :) = (bestGenes(k(1), :) + bestGenes(k(2), :))/2;
    end


end