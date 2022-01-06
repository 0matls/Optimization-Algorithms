%%  Optimization Techniques
%   1st assignement 18-11-21 ex3 - Fibonacci - sup function 3
%  

function [a, b, k] = fibo( l, a1, b1, f )
k = 1;
n = 1;
bin = 1; %bin from binet
while( (b1 - a1)/bin >= l)
    bin = binet(n);
    n = n + 1;
end
n = n + 1;
F = fibon(1,1,n);
a=zeros(1,n-1);
b=zeros(1,n-1);
a(k) = a1;
b(k) = b1;
x1 = a1 + ( F(n-k-1) / F(n-k+1) )*(b1 - a1); 
x2 = a1 + ( F(n-k) / F(n-k+1) )*(b1 - a1);
F1 = subs(f,x1);
F2 = subs(f,x2);
while( n - k > 1 ) %all F are +1 cause cannot start from F(0) and k=k+1 is before the if statement
    if( x1<=a(k) || x2>=b(k))
       disp('error');
       break;
    end
    k = k + 1;
    if( F1 < F2 )
        a(k) = a(k-1);
        b(k) = x2;
        x2 = x1;
        F2 = F1;
        x1 = a(k) + ( F(n-k) / F(n-k+2) )*(b(k) - a(k)); 
        F1 = subs(f,x1);
    else
        a(k) = x1;
        b(k) = b(k-1);
        x1 = x2;
        F1 = F2;
        x2 = a(k) + ( F(n-k+1) / F(n-k+2) )*(b(k) - a(k));
        F2 = subs(f,x2); 
    end
end
end

