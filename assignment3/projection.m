%%  Optimization Techniques
%   3rd assignement 20-12-21 Task 2-3-4 - Steepest Descend Method with
%   Projection - help function 1


function [xbar,ybar] = projection(x,y)
    if x <= -15 
        xbar = -15;
    elseif x < 15
        xbar = x;
    else
        xbar = 15;
    end

    if y <= -20
        ybar = -20;
    elseif y < 12
        ybar = y;
    else
        ybar = 12;

    end
end
