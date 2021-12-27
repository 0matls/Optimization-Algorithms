%%  Optimization Techniques
%   3rd assignement 20-12-21 Task 2-3-4 - Steepest Descend Method with
%   Projection


function [x, g, k, grad] = steepestDescentProjection(x0, y0, f, gradF, epsilon, gamma,s)
x = [x0 y0]; %starting point (x,y)
grad = [];   %matrix containing the grad's value on every iteration
g = []; %vector containing the used gamma on every iteration
k = 1;  %iterations
maxIterations = 1000;

if restrictions(x(k,1),x(k,2)) == false % used in the last task
    [x(k,1),x(k,2)] = projection(x(k,1), x(k,2));
end

while norm(gradF(x(k,1), x(k,2))) > epsilon && k < maxIterations

    grad(k,:) = gradF(x(k,1), x(k,2));
    g(k) = gamma;
    xbar = x(k,1) - s * grad(k,1);  
    ybar = x(k,2) - s * grad(k,2); 
    [xbar,ybar] = projection(xbar,ybar);
       
    x(k+1,1) = x(k,1) + g(k)* (xbar - x(k,1));
    x(k+1,2) = x(k,2) + g(k) * (ybar - x(k,2));
    
    k = k +1;
    if restrictions(x(k,1),x(k,2)) == false
        [x(k,1),x(k,2)] = projection(x(k,1), x(k,2));
    end
    
end
min_x = x(k,1);
min_y = x(k,2);
value = f(x(k,1),x(k,2));
%disp(min_x);
%disp(min_y);
%disp(value);
end

