%%  Optimization Techniques
%   3rd assignement 20-12-21 Task 2-3-4 - Steepest Descend Method with
%   Projection - help function 2


function isInX = restrictions(x,y)
isInX = false;
if x >= -15 && x <= 15
    if y >= -20 && y<=12
        isInX = true;
    end
end
