%%  Optimization Techniques
%   1st assignement 18-11-21 ex4 sup function
%   

function [ a, b, k ] = bisectionDerivativeMethod( l, a1, b1, f )
%   l > 2e always
k = 1;
df = diff(f,'x');
a=[];
b=[];
n = ceil( log2( (b1-a1) / l ) );
a(k) = a1;
b(k) = b1;
while( k <= n ) % k = n because of k = k +1 place
    x = (a(k) + b(k))/2;
    dfx = subs(df,x);
    k = k + 1;
    if( dfx == 0 )
        a(k) = x;
        b(k) = x;
        disp([num2str(x) ' is the min of function!']);
        break;
    elseif( dfx < 0 )
        a(k) = x;
        b(k) = b(k-1);
    else
        a(k) = a(k-1);
        b(k) = x;
    end
end
end

