%%  Optimization Techniques
%   2nd assignement 07-12-21 goldenSectionMethod - in ordr to minimize f(gamma)

function [a, b, k] = goldenSectionMethod(l, a0, b0, f)
a = a0;  
b = b0;   
k = 0;       
gamma = 0.618033988749;
x1 = a0 + (1-gamma)*(b0-a0);
x2 = a0 + gamma*(b0-a0);
x1i = f(x1);
x2i = f(x2);
while (b(k+1) - a(k+1)) > l 
    k = k + 1;

    if (x1i > x2i)
        a(k+1) = x1;
        b(k+1) = b(k);
        x1 = x2;
        x2 = a(k+1) + gamma*(b(k+1)-a(k+1));
        x1i = x2i;
        x2i = f(x2);
    elseif (x1i <= x2i)
        b(k+1) = x2;
        a(k+1) = a(k);
        x2 = x1;
        x1 = a(k+1) + (1-gamma)*(b(k+1)-a(k+1));
        x2i = x1i;
        x1i = f(x1);
    end
end
end
