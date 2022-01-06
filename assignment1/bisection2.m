clear; clc; close all;

%%  Optimization Techniques
%   1st assignement 18-11-21 ex1 - bisection Method - part 2
%  


f_1=@(x)(x-3).^2 +sin(x+3).^2;
f_2=@(x)(x-1).*cos(x/2) + x.^2;
f_3 =@(x)(x+2).^2+(exp(x-2)).*sin(x+3);


l = 0.01;
search_interval_length = length(l);
epsilon = linspace(0.0001, 0.00499,15);
epsilon_lenght = length(epsilon);

alpha = -4;
beta = 4;
functions = {f_1; f_2; f_3};

iterations = zeros(epsilon_lenght,3);
for i= 1 : length(functions)
    f = functions{i};
    for j=1:epsilon_lenght
       alpha = -4;
       beta = 4;
       iterations(j,i) = 0;
       while true 
           if(2*epsilon(j) > l) %determinate if epsilon and l interval make sense when selected together
              iterations(j,i) = NaN;
              break
           end
            if ((beta - alpha) < l)
              %fprintf("the minimun is inside the interval [%d, %d], its lenght is %d \n",alpha, beta, beta - alpha)
              break
           end
            x1 = (alpha + beta)/2 - epsilon(j);
            x2 = (alpha + beta)/2 + epsilon(j);
            x1i = f(x1);
            x2i = f(x2);
            if (x1i > x2i)
                alpha = x1;
            elseif (x1i < x2i)
                beta = x2;
            else
                iterations(j,i) = iterations(j,i) + 1;
                fprintf("SO LUCKY YOU FOUND THE MINIMUM. HOW \n")
                alpha = x1i;
                beta = x1i;
                break
            end
            iterations(j,i) = iterations(j,i) + 1;  
            %fprintf("the minimun is inside the interval [%d, %d], its lenght is %d \n", alpha, beta, beta - alpha)
    
       end
    end
end
% in every iteration we calculate twice the value of the fuction, thus...
calculations = 2*iterations;

figure(1)
clf
subplot(3,1,1)
plot(epsilon,calculations(:,1))
title('number of function calculations','Interpreter','latex')
ylabel('$f_1(x)$ calculations','Interpreter','latex');
xlabel('${\epsilon}$','Interpreter','latex');
subplot(3,1,2)
plot(epsilon,calculations(:,2))
ylabel('$f_2(x)$ calculations','Interpreter','latex');
xlabel('${\epsilon}$','Interpreter','latex');
subplot(3,1,3)
plot(epsilon,calculations(:,3))
ylabel('$f_3(x)$ calculations','Interpreter','latex');
xlabel('${\epsilon}$','Interpreter','latex');
