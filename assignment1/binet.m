%%  Optimization Techniques
%   1st assignement 18-11-21 ex3 - Fibonacci - sup function 2
% 

function a = binet( n )
n = n + 1;
a = ( (1 + sqrt(5))^n - (1 - sqrt(5))^n )/ ( sqrt(5)*2^n );

end

