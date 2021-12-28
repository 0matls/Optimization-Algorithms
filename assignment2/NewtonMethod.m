%%  Optimization Techniques
%   2nd assignement 07-12-21 Task 3 - Newton's Method


function [x, g, k,d] = NewtonMethod(x0, y0, f, gradF, hessianF, epsilon, selectGamma)

x = [x0 y0]; %starting point (x,y)
d = []; %matrix containing the grad's value on every iteration
g = []; %vector containing the used gamma on every iteration
k = 1;  %iterations
maxIterations = 1000;
gamma = NaN;

while norm(gradF(x(k,1), x(k,2))) > epsilon && k < maxIterations
    d2 = inv(hessianF(x(k,1), x(k,2)));
    aa = hessianF(x(k,1), x(k,2));
    d1 = gradF(x(k,1), x(k,2));
    try chol(aa);
       % disp('Matrix is symmetric positive definite.')
    catch ME
        %disp('Matrix is NOT symmetric positive definite')
    end
    d(k,:) = -d2*d1;
    switch selectGamma
        case "constant Gamma"
            gamma = 1;
        case "minimized f(gamma)"
            minf = @(gamma) f(x(k,1)+gamma*d(k,1), x(k,2)+gamma*d(k,2) ); 

            [agr, ~, ~] = goldenSectionMethod(0.001,0.001,100,minf);
            gamma = agr(end);
        case "Armijo's Rule"
            gamma = ArmijoRule(f, x(k,:), gradF, 0.01, 0.5, 50);
    end
    g(k) = gamma;
    x(k+1,:) = x(k,:) + gamma*d(k, :);
    k = k +1;
end

end
