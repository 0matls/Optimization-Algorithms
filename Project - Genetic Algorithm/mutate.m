%%
% function to mutate the chromosomes of a gene, given some (small)
% probability, the mutated chromosomes are random, following uniform
% distribution in a given range

%%
function mutatedGenes = mutate(genes, NumberOfMutatedGenes, centerRangeX, centerRangeY, sigmaRange, amplitudeRange, mutationProbability)

    lengthOfGenes = size(genes,2);
    mutatedGenes = genes;
    
    for i = 1  : NumberOfMutatedGenes
        for j = 1 : lengthOfGenes
            if rand <= mutationProbability
                mutatedIndex = mod(j, 5);
                switch mutatedIndex
                    case 1
                        mutatedGenes(i, j) = unifrnd(centerRangeX(1), centerRangeX(2));
                    case 2
                        mutatedGenes(i, j) = unifrnd(centerRangeY(1), centerRangeY(2));
                    case 3
                        mutatedGenes(i, j) = unifrnd(sigmaRange(1), sigmaRange(2));
                    case 4
                        mutatedGenes(i, j) = unifrnd(sigmaRange(1), sigmaRange(2));
                    case 0
                        mutatedGenes(i, j) = unifrnd(amplitudeRange(1), amplitudeRange(2));
                end
            end
            
        end
    end
 
end