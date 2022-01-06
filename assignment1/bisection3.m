clear; clc; close all;

%%  Optimization Techniques
%   1st assignement 18-11-21 ex1 - bisection Method - part 3
%


f_1=@(x)(x-3).^2 +sin(x+3).^2;
f_2=@(x)(x-1).*cos(x/2) + x.^2;
f_3 =@(x)(x+2).^2+(exp(x-2)).*sin(x+3);

% l = logspace(-2.6778, -1,20);

% epsilon = 0.001;
l = logspace(-8, -1,20);
search_interval_length = length(l);
epsilon = 0.0000000001;

epsilon_lenght = length(epsilon);

alpha_start = -4;
beta_start = 4;
functions = {f_1; f_2; f_3};

iterations = zeros(search_interval_length,3);
alpha_array = cell(search_interval_length,3);
beta_array = cell(search_interval_length,3);
%%
for i= 1 : length(functions)
    f = functions{i};
    for j=1:search_interval_length
        
        alpha = alpha_start; %dont have (1) in order to erase all the data
        beta = beta_start;   % from the previous iteration
        k = 0;
        while true 
            if(2*epsilon > l(j)) %determinate if epsilon and l interval make sense when selected together
                iterations(j,i) = NaN;
                alpha_array{j,i} = alpha;
                beta_array{j,i} = beta;
                break
            end
            if ((beta(k+1) - alpha(k+1)) < l(j))
                alpha_array{j,i} = alpha;
                beta_array{j,i} = beta;
                iterations(j,i) = k;
                break
            end
            k = k + 1;
            x1 = (alpha(k) + beta(k))/2 - epsilon;
            x2 = (alpha(k) + beta(k))/2 + epsilon;
            x1i = f(x1);
            x2i = f(x2);
            if (x1i > x2i)
                alpha(k+1) = x1;
                beta(k+1) = beta(k);
            elseif (x1i <= x2i)
                beta(k+1) = x2;
                alpha(k+1) = alpha(k);
            end
        end
    end
end
% in every iteration we calculate twice the value of the fuction, thus...
calculations = 2*iterations;

%%
figure(1)
clf
subplot(3,1,1)
plot(l,calculations(:,1))
title('number of function calculations','Interpreter','latex')
ylabel('$f_1(x)$ calculations','Interpreter','latex');
xlabel('$l$','Interpreter','latex');
subplot(3,1,2)
plot(l,calculations(:,2))
ylabel('$f_2(x)$ calculations','Interpreter','latex');
xlabel('$l$','Interpreter','latex');
subplot(3,1,3)
plot(l,calculations(:,3))
ylabel('$f_3(x)$ calculations','Interpreter','latex');
xlabel('$l$','Interpreter','latex');
figure(2)
clf
for i = 1 : 3
    j = randi([1 search_interval_length]);
    subplot(3,3,i)
    plot(0:iterations(j,1),alpha_array{j,1})
    hold on 
    plot(0:iterations(j,1),beta_array{j,1})
    legend('a(k)','b(k)', 'Location', 'Best');
    title('$f_1(x)$','Interpreter','latex');
    xlabel('$k$','Interpreter','latex');
    subplot(3,3,3+i)
    plot(0:iterations(j,2),alpha_array{j,2})
    hold on 
    plot(0:iterations(j,2),beta_array{j,2})
    legend('a(k)','b(k)', 'Location', 'Best');
    title('$f_2(x)$','Interpreter','latex');
    xlabel('$k$','Interpreter','latex');
    %title(['f2 ' num2str(j)])
    subplot(3,3,6+ i)
    plot(0:iterations(j,3),alpha_array{j,3})
    hold on 
    plot(0:iterations(j,3),beta_array{j,3})
    legend('a(k)','b(k)', 'Location', 'Best');
    title('$f_3(x)$','Interpreter','latex');
    xlabel('$k$','Interpreter','latex');
    %title(['f3 ' num2str(j)])
end
