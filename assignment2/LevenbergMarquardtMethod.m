%%  Optimization Techniques
%   2nd assignement 07-12-21 Task 4 - Levenberg's - Marquardt's Method


function [x, g, k,d] = LevenbergMarquardtMethod(x0, y0, f, gradF, hessianF, epsilon, method)

x = [x0 y0]; %starting point (x,y)
d = []; %matrix containing the grad's value on every iteration
d1 = [];
d3 = [];
g = []; %vector containing the used gamma on every iteration
k = 1; %iterations
maxIterations = 1000000;
gamma =NaN;
while norm(gradF(x(k,1), x(k,2))) > epsilon && k < maxIterations 
   
    eigens = eig(hessianF(x(k,1), x(k,2)));
    mk = ceil(sum(abs(eigens)) + 2);
    aa = hessianF(x(k,1), x(k,2)) + mk * eye(2);
    isHessianPositive = false;
    while ~isHessianPositive   
        try chol(aa);
            isHessianPositive = true;
        catch ME
            mk = mk + 1;
            aa = hessianF(x(k,1), x(k,2)) + mk * eye(2);
        end
    end
    d2 = inv(aa);
    d1 = gradF(x(k,1), x(k,2));
    d(k,:) = -d2*d1;
    switch method
        case "constant Gamma"
            gamma = 1;
        case "minimized f(gamma)"
            minf = @(gamma) f(x(k,1)+gamma*d(k,1), x(k,2)+gamma*d(k,2) );
            [agr, ~, ~] = goldenSectionMethod(0.001,0,100,minf);
            gamma = agr(end);
        case "Armijo's Rule"
            gamma = ArmijoRule(f, x(k,:), gradF, 0.01, 0.5, 50);
    end
    g(k) = gamma;
    x(k+1,:) = x(k,:) + gamma*d(k, :);
    k = k +1;
end

end
