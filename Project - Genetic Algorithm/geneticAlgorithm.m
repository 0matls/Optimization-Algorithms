clear; close all; clc;
%%
[cseed] = clock;
rng(cseed(6));
numberOfGaussians = 12;
maxGenerations = 10000;
populationSize = 100;
mutationProbability = 0.03;
mutation2Probability = 0.05;

centerRangeX = [-1.5 2.5];
centerRangeY = [-2.5 1.5];
sigmaRange = [0.001 0.75];  

percentageOFGenesToBeTranfered = 0.1;
percentageOfGenesToBeMutated = 0.3;
percentageOfGenesToBeMutated2 = 0.3;
percentageOfGenesToBeCrossovered = 0.2;
percentageOfRandomGenes = 0.1;

minErrorToAchieve = 0.0001;

numberOfRegions = 10;
numberOfTests = 1000;
wayToCreateTestingRegion = "uniform"; % linear or uniform
%%

xRange = [-1 2];
yRange = [-2 1];
f=@(x,y)  sin(x+y).*sin(y.^2);
numberOfChromosomes = 5;

linx = xRange(1):0.01:xRange(2);
liny = yRange(1):0.01:yRange(2);
[X,Y] = meshgrid(linx,liny);
Z = f(X,Y);
maxz = max(Z(:));
minz = min(Z(:));
amplitudeRange = [minz maxz]; % we choose the amplitude range to be within
% the min and max value of the given function

[Xtest ,Ytest] = creatingTestingRegion(xRange, yRange, numberOfRegions, numberOfTests, wayToCreateTestingRegion);

%%
% gene creating for the first generation - random data
genes = createRandomGenes(centerRangeX, centerRangeY, sigmaRange, amplitudeRange, numberOfChromosomes, numberOfGaussians, populationSize);

generation = 1;

fitnessFunctionScoreOnGenes = zeros(populationSize, 1);
bestGene = zeros(maxGenerations, numberOfGaussians*numberOfChromosomes);

generationsMinError = zeros(maxGenerations, 1);

%calculate the fitness function score for every gene in the generation
for i=1:populationSize
    fitnessFunctionScoreOnGenes(i) = calculateFitnessFunction(f, Xtest, Ytest, numberOfChromosomes, genes(i,1:end-1));
end

%%
% update genes of the population of the 1st generation with their scores 
% based the fitness function 
genes(:,end) = fitnessFunctionScoreOnGenes; 

% sort the genes based on their fitness function scores, first is the gene
% with the lowest score, which we consider the best gene in our case
genes = sortrows(genes,numberOfGaussians*numberOfChromosomes + 1);
                                                                            
bestGene(generation,:) = genes(1, 1:end-1);    %generation = 1 right now
generationsMinError(generation) = genes(1,end); %generation = 1 right now



% next generation - define how many genes will be created using mutation,
% crossover, instant transfer, or randomly

NumberOfbestGenesTransfered = ceil(populationSize*percentageOFGenesToBeTranfered);
NumberOfMutatedGenes = ceil(populationSize*percentageOfGenesToBeMutated);
NumberOfMutated2Genes = ceil(populationSize*percentageOfGenesToBeMutated2);
NumberOfCrossoveredGenes =  ceil(populationSize*percentageOfGenesToBeCrossovered);
NumberOfRandomGeneratedGenes = populationSize - NumberOfbestGenesTransfered ...
           - NumberOfMutated2Genes - NumberOfMutatedGenes - NumberOfCrossoveredGenes;


%%
[cStart] = clock; % to track the time
timeStart = ((cStart(3)*24 + cStart(4))*60 + cStart(5))*60 + cStart(6);
tic;

while generationsMinError(generation) > minErrorToAchieve && generation < maxGenerations
    
    % print the error every n generations, plus the time passed
    if ~mod(generation,200)
        fprintf('[%f] Generation %d has error %f\n', toc, generation, generationsMinError(generation));
        tic
    end
    
    %new generation
    generation = generation + 1;
    genesOfNewGeneration = 0;
    
    %apply all ways to create the next generation's genes
    %below, transfer of the best genes of the last generation
    bestGenesTransfered = genes(genesOfNewGeneration + 1:...
                                 genesOfNewGeneration + NumberOfbestGenesTransfered,1:end-1);
                             
    genesOfNewGeneration = NumberOfbestGenesTransfered;
    
    % mutation, mutate some genes of the last generation
    mutationIndexes = randperm(populationSize);
    genesForMutation = genes(mutationIndexes(1 : NumberOfMutatedGenes), 1 : end -1);
    mutatedGenes = mutate(genesForMutation, NumberOfMutatedGenes, centerRangeX,...
                    centerRangeY, sigmaRange, amplitudeRange, mutationProbability);
    genes(genesOfNewGeneration + 1: genesOfNewGeneration + NumberOfMutatedGenes,...
                     1:end-1) = mutatedGenes;                
    genesOfNewGeneration = genesOfNewGeneration + NumberOfMutatedGenes;
    
    % mutation2 - mutate the top #NumberOfMutated2Genes of the last
    % generation
    genesForMutation2 = genes(1 : NumberOfMutated2Genes, 1 : end -1);
    mutated2Genes = mutate2(genesForMutation2, NumberOfMutated2Genes, centerRangeX,...
                    centerRangeY, sigmaRange, amplitudeRange, mutation2Probability);
    genes(genesOfNewGeneration + 1: genesOfNewGeneration + NumberOfMutated2Genes,...
                     1:end-1) = mutated2Genes;                
    genesOfNewGeneration = genesOfNewGeneration + NumberOfMutated2Genes;
    
    % crossover the best genes
    crossoveredGenes = crossover(bestGenesTransfered,NumberOfCrossoveredGenes);
    genes(genesOfNewGeneration + 1: genesOfNewGeneration + NumberOfCrossoveredGenes,...
                     1:end-1) = crossoveredGenes;
                 
    genesOfNewGeneration = genesOfNewGeneration + NumberOfCrossoveredGenes;
    
    % add random genes
    genes(genesOfNewGeneration + 1 : populationSize, :) = createRandomGenes(centerRangeX, ...
                                centerRangeY, sigmaRange, amplitudeRange, numberOfChromosomes,...
                                 numberOfGaussians, populationSize - genesOfNewGeneration);
                             
    % creation of testing points, different in every generation, to elimite
    % overfitting. We opt to choose random points, but also span the whole
    % region quite uniformly.
    if wayToCreateTestingRegion == "uniform"
        [Xtest ,Ytest] = creatingTestingRegion(xRange, yRange, numberOfRegions, numberOfTests, wayToCreateTestingRegion);
    end
    
    % calculate and update fitness function scores
    for i=1:populationSize
        fitnessFunctionScoreOnGenes(i) = calculateFitnessFunction(f, Xtest, Ytest, numberOfChromosomes, genes(i,1:end-1) );
    end
    genes(:, end) = fitnessFunctionScoreOnGenes;
    genes = sortrows(genes,numberOfGaussians*numberOfChromosomes + 1);
    
    bestGene(generation,:) = genes(1, 1:end-1);    
    generationsMinError(generation) = genes(1,end);
    
end
%%
if generationsMinError(generation) < minErrorToAchieve
    maxGenerations = generation;
    bestGene(generation+1:end,:) = [];
    generationsMinError(generation+1:end,:) = [];
end

[cstop] = clock;
timeFinished = ((cstop(3)*24 + cstop(4))*60 + cstop(5))*60 + cstop(6);
minutesLasted = floor( (timeFinished - timeStart) / 60);
secondsLasted = ceil(mod(timeFinished - timeStart, 60));

bestGen = find(generationsMinError == min(generationsMinError));
finalBestGene = bestGene(bestGen(end), :);

finalMessage = sprintf('Finished at generation %d.\nBest generation is %d with error %f after %d minutes and %f seconds\n',...
    generation, bestGen(end), generationsMinError(bestGen(end)), minutesLasted, secondsLasted);
disp(finalMessage);                                

%%
figure(1)
plot(1:maxGenerations,generationsMinError,'o');
title('Mean Square Error of the best person in each generation', 'Interpreter', 'latex')
xlabel('generations', 'Interpreter', 'latex') 
ylabel('MSE', 'Interpreter', 'latex')
zlabel('f(x,y)', 'Interpreter', 'latex')
myfun = @(x,y) 0;
for j=1:numberOfChromosomes:size(bestGene,2)
myfun = @(x,y)  myfun(x,y) + finalBestGene(j+4) .* exp(-(((x-finalBestGene(j)).^2 ./ (2*finalBestGene(j+2)^2)) + ((y-finalBestGene(j+1)) .^2 ./(2*finalBestGene(j+3)^2))));
end
Zbar = myfun(X,Y);
minz = min([Z(:); Zbar(:)]);
maxz = max([Z(:); Zbar(:)]);
figure(2);
subplot(1,2,1)
surf(X,Y,f(X,Y));
title('3D plot of the given function', 'Interpreter', 'latex')
xlabel('x', 'Interpreter', 'latex') 
ylabel('y', 'Interpreter', 'latex')
zlabel('f(x,y)', 'Interpreter', 'latex')

axis([xRange(1) xRange(2) yRange(1) yRange(2) minz maxz])

subplot(1,2,2)
surf(X,Y,myfun(X,Y));
title('3D plot of the approximation' , 'Interpreter', 'latex')
xlabel('x', 'Interpreter', 'latex') 
ylabel('y', 'Interpreter', 'latex')
zlabel('f(x,y)', 'Interpreter', 'latex')
axis([xRange(1) xRange(2) yRange(1) yRange(2) minz maxz])

figure(3)
subplot(1,2,1)
contour(X,Y,Z);
title('Contour plot of the given function' , 'Interpreter', 'latex')
xlabel('x', 'Interpreter', 'latex') 
ylabel('y', 'Interpreter', 'latex')
zlabel('f(x,y)', 'Interpreter', 'latex')
axis([xRange(1) xRange(2) yRange(1) yRange(2)])

subplot(1,2,2)
contour(X,Y,Zbar);
title('Contour plot of the aproximation' , 'Interpreter', 'latex')
xlabel('x', 'Interpreter', 'latex') 
ylabel('y', 'Interpreter', 'latex')
zlabel('f(x,y)', 'Interpreter', 'latex')
axis([xRange(1) xRange(2) yRange(1) yRange(2)])

