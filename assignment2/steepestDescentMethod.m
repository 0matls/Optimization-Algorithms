%%  Optimization Techniques
%   2nd assignement 07-12-21 Task 2 - Steepest Descend Method

function [x, g, k, grad] = steepestDescentMethod(x0, y0, f, gradF, epsilon, selectGamma)

x = [x0 y0]; %starting point (x,y)
grad = [];   %matrix containing the grad's value on every iteration
g = []; %vector containing the used gamma on every iteration
k = 1;  %iterations
maxIterations = 100000;
gamma = NaN;
while norm(gradF(x(k,1), x(k,2))) > epsilon && k < maxIterations
   
    grad(k,:) = -gradF(x(k,1), x(k,2));
   
    switch selectGamma
        case "constant Gamma"
            gamma = 1;
        case "minimized f(gamma)"
            minf = @(gamma) f(x(k,1)+gamma*grad(k,1), x(k,2)+gamma*grad(k,2) ); 
            [agr, ~, ~] = goldenSectionMethod(0.001,0,1000,minf);
            gamma = agr(end);
            
        case "Armijo's Rule"
            gamma = ArmijoRule(f, x(k,:), gradF, 0.01, 0.5, 50);      
    end
    
    g(k) = gamma;
    x(k+1,:) = x(k,:) + gamma*grad(k, :);
    k = k +1;
    disp(norm(gradF(x(k,1), x(k,2))) > epsilon)
end

end

