clear; clc; close all;

%%  Optimization Techniques
%   1st assignement 18-11-21 ex1 - bisection Method - part 1 of 3
%   

%%
f_1=@(x)(x-3).^2 +sin(x+3).^2;
f_2=@(x)(x-1).*cos(x/2) + x.^2;
f_3 =@(x)(x+2).^2+(exp(x-2)).*sin(x+3);

figure(1)
clf
fplot(f_1,[-4, 4])
hold on
fplot(f_2, [-4, 4])
fplot(f_3, [-4, 4])
legend('$f_1(x)$', '$f_2(x)$', '$f_3(x)$', 'Location', 'Best', 'Interpreter','latex');
hold off

%%
%  here we will try lots of epsilon-l interval combinations, to see which of
%  these are more favorable
l = [0.00001 0.00005 0.0001 0.0005 0.001 0.005 0.01 0.05 0.1 0.5];
search_interval_length = length(l);
epsilon = [0.0000001 0.000000499 0.000001 0.00000499 0.00001 0.0000499 0.0001 0.000499 0.001 0.00499];%[0.000001 0.00000499 0.00001 0.0000499 0.0001 0.000499 0.001 0.00499 0.01 0.0499];
epsilon_lenght = length(epsilon);

% search interval [a, b]
alpha = -4;
beta = 4;

%%
iterations = zeros(search_interval_length,epsilon_lenght);
for i=1:search_interval_length
    for j=1:epsilon_lenght
       alpha = -4;
       beta = 4;
       iterations(i, j) = 0;
       while true 
           if(2*epsilon(j) > l(i)) %determinate if epsilon and l interval make sense when selected together
              iterations(i, j) = NaN;
              break
           end
            if ((beta - alpha) < l(i))
              %fprintf("the minimun is inside the interval [%d, %d], its lenght is %d \n",alpha, beta, beta - alpha)
              break
           end
            x1 = (alpha + beta)/2 - epsilon(j);
            x2 = (alpha + beta)/2 + epsilon(j);
            x1i = f_1(x1);
            x2i = f_1(x2);
            if (x1i > x2i)
                alpha = x1;
            elseif (x1i < x2i)
                beta = x2;
            else
                iterations(i, j) = iterations(i, j) + 1;
                //fprintf("SO LUCKY YOU FOUND THE MINIMUM. HOW \n")
                alpha = x1i;
                beta = x1i;
                break
            end
            iterations(i, j) = iterations(i, j) + 1;  
            %fprintf("the minimun is inside the interval [%d, %d], its lenght is %d \n", alpha, beta, beta - alpha)
            %fprintf("iterations are: %d \n", iterations(i, j))
       end
    end
end

%% in every iteration we calculate twice the value of the fuction, thus...
calculations = 2*iterations;

figure(2)
clf
yvalues = num2cell(l);
xvalues = num2cell(epsilon);
heatmap(xvalues,yvalues,calculations);
title('different combinations of l and e, NaN if 2e > l');
ylabel('l intervals');
xlabel('e');
