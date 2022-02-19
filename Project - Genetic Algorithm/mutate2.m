%%
% function to mutate the chromosomes of a gene, given some (small)
% probability, the mutated chromosomes are the original ones but slightly 
% shifted

function mutatedGenes = mutate2(genes, NumberOfMutatedGenes, centerRangeX, centerRangeY, sigmaRange, amplitudeRange, mutationProbability)

    lengthOfGenes = size(genes,2);
    mutatedGenes = genes;
    
    for i = 1  : NumberOfMutatedGenes
        for j = 1 : lengthOfGenes
            if rand <= mutationProbability
                mutatedIndex = mod(j, 5);
                switch mutatedIndex
                    case 1
                        mutatedGenes(i, j) = min(max(centerRangeX(1), mutatedGenes(i, j) + unifrnd(-0.1,0.1)), centerRangeX(2));
                    case 2
                        mutatedGenes(i, j) = min(max(centerRangeY(1), mutatedGenes(i, j) + unifrnd(-0.1,0.1)), centerRangeY(2));
                    case 3
                        mutatedGenes(i, j) = min(max(sigmaRange(1), mutatedGenes(i, j) + unifrnd(-0.1,0.1)), sigmaRange(2));
                    case 4
                        mutatedGenes(i, j) = min(max(sigmaRange(1), mutatedGenes(i, j) + unifrnd(-0.1,0.1)), sigmaRange(2));
                    case 0
                        mutatedGenes(i, j) = min(max(amplitudeRange(1), mutatedGenes(i, j) + unifrnd(-0.05,0.05)), amplitudeRange(2));
                end
            end
            
        end
    end
 
end