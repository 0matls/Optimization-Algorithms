%%
% function to create the testing region
% this function creates a set of testing points in a number of regions that
% we devide our main region into many equals, and we take a number (approximateNumberOfTests
% approximately) in order to span the whole region with random points to
% use in the testing. We prefer to create random points uniformly, rather
% than linearly, because the latter might cause us overfitting problems.
% Thus we prefer to choose different points every time.


function [Xtest ,Ytest] = creatingTestingRegion(xRange, yRange, numberOfRegions, approximateNumberOfTests, way)

%   approximateNumberOfTests is the approximate number of places to be
%   returned, the number will alwayes be a square number

if way == "uniform"
    xRegions = linspace(xRange(1), xRange(2), numberOfRegions + 1);
    yRegions = linspace(yRange(1), yRange(2), numberOfRegions + 1);

    numberPerRegion = ceil (sqrt(approximateNumberOfTests) / numberOfRegions);

    x = nan(numberPerRegion * numberOfRegions, 1);
    y = nan(numberPerRegion * numberOfRegions, 1);
    for i = 1 : numberOfRegions
    x( (i - 1) * numberPerRegion + 1 : i * numberPerRegion)  = sort(unifrnd(xRegions(i), xRegions(i + 1),...
                                                                         numberPerRegion, 1));
    y( (i - 1) * numberPerRegion + 1 : i * numberPerRegion)  = sort(unifrnd(yRegions(i), yRegions(i + 1),...
                                                                         numberPerRegion, 1));
    end
    if isempty(find(x == xRange(1), 1))
        x = [xRange(1); x];
    end
    if isempty(find(x == xRange(2), 1))
        x = [x; xRange(2)];
    end
    if isempty(find(y == yRange(1), 1))
        y = [yRange(1); y];
    end
    if isempty(find(y == yRange(2), 1))
        y = [y; yRange(2)];
    end
elseif way == "linear"
    numberPerRegion = ceil(sqrt(approximateNumberOfTests));
    x = linspace(xRange(1), xRange(2), numberPerRegion);
    y = linspace(yRange(1), yRange(2), numberPerRegion);

end
    
    [Xtest, Ytest] = meshgrid(x,y);

end

