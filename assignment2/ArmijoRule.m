%%  Optimization Techniques
%   2nd assignement 07-12-21 - Armijo's Rule


function [gamma] = ArmijoRule(f, x, gradF, alpha, beta, s)

k = 1;
d(k,:) = -gradF(x(k,1), x(k,2));
m = 1;
aa = -alpha * (beta ^ m) * s * d(k,:) * (-d(k,:))';
gamma = s * (beta ^ m);

x(k+1,:) = x(k,:) + gamma*d(k, :);
deltaf = f(x(k,1), x(k,2)) - f(x(k+1,1), x(k+1,2));

while  deltaf < aa
    m = m + 1;
    gamma = s * (beta ^ m);
    
    x(k+1,:) = x(k,:) + gamma*d(k, :);
    
    deltaf = f(x(k,1), x(k,2)) - f(x(k+1,1), x(k+1,2));
    
    aa = -alpha * (beta ^ m) * s * d(k,:) * (-d(k,:))';

end

end
