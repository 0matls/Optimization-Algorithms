%%  Optimization Techniques
%   1st assignement 18-11-21 ex3 - Fibonacci - sup function 1
%


function a = fibon( a0, a1 , n )
if(n == 0)
    a = a0;
elseif(n == 1)
    a = [a0 a1];
else
    a = zeros(1,n);
    a(1) = a0;
    a(2) = a1;
    for i = 3 : n+1
        a(i) = a(i-1) + a(i-2);
    end
end
end

