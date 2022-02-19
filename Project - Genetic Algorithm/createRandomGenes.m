%%
function genes = createRandomGenes(centerRangeX, centerRangeY, sigmaRange, amplitudeRange, numberOfChromosomes, numberOfGaussians, numberToCreate)
% creation of brand new set of genes, random, for uniform distribution 
% within a given range
% this function is used for the initialization of the first generation, as
% well as for the creation of a percentage of random genes in every new 
% generation
% 
genes = zeros(numberToCreate, numberOfGaussians*numberOfChromosomes + 1);
for i=1:numberToCreate
    for j = 1 :numberOfChromosomes : numberOfGaussians * numberOfChromosomes
        genes(i,j)   =  unifrnd(centerRangeX(1), centerRangeX(2));                               
        genes(i,j+1) =  unifrnd(centerRangeY(1), centerRangeY(2));                            
        genes(i,j+2) =  unifrnd(sigmaRange(1), sigmaRange(2));          
        genes(i,j+3) =  unifrnd(sigmaRange(1), sigmaRange(2));  
        genes(i,j+4) =  unifrnd(amplitudeRange(1), amplitudeRange(2));  
    end
end


end

