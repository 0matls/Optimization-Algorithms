%%
function score = calculateFitnessFunction(f, Xtest, Ytest, chromosomeSize, geneTobeTested)
%returns the score of the gene, double, as lower as the score is, the
%"better" the gene is considered to be 
%the mean square error is used in order to calculate the error of our
%approximation to the given function 

fhat = @(x,y) 0;
for j= 1 : chromosomeSize : size(geneTobeTested,2)
    fhat = @(x,y)  fhat(x,y) + geneTobeTested(end,j+4) .* exp(-(((x-geneTobeTested(end,j)).^2 ./ ...
         (2*geneTobeTested(end,j+2)^2)) + ((y-geneTobeTested(end,j+1)) .^2 ./(2*geneTobeTested(end,j+3)^2))));
end
error = (f(Xtest, Ytest) - fhat(Xtest, Ytest)).^2;
score = sum(error(:)) / length(error(:));
 

end



