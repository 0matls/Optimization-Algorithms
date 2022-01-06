clear; clc; close all;

%%  Optimization Techniques
%   1st assignement 18-11-21 ex4 main script - needs 1 sup function
% 
  
syms x;
f_1 = (x-3).^2 +sin(x+3).^2;
f_2 = (x-1).*cos(x/2) + x.^2;
f_3 = (x+2).^2+(exp(x-2)).*sin(x+3);
%l = logspace(-8, -1,20);
%epsilon = 0.0000000001;
l = logspace(-2.6778, -1,20);
search_interval_length = length(l);
epsilon = 0.001;
alpha_start = -4;
beta_start = 4;
functions = {f_1; f_2; f_3};

%l = 0.001 : 0.001 : 0.05;
lArray = zeros([length(l) length(functions)]);
alpha_array = cell(search_interval_length,3);
beta_array = cell(search_interval_length,3);
for i = 1 : length(l)
    for j = 1 : length(functions)
        [a, b, k] = bisectionDerivativeMethod(l(i),alpha_start,beta_start,functions{j});
        lArray(i,j) = k;
        alpha_array{i,j} = a;
        beta_array{i,j} = b;
    end
end



%%
figure(4)
clf
for i = 1 : length(functions)
subplot(length(functions),1,i)
    plot(l, lArray(:,i))
    title(['times f' num2str(i) '(x) is calculated']);
    xlabel('l');
    ylabel('calculations');
end
%%
figure(2)
clf
num_of_diff_l_values = 3;
randj = randperm(search_interval_length, num_of_diff_l_values);
for i = 1 : length(functions)
    for j = 1 : num_of_diff_l_values
        subplot(length(functions),num_of_diff_l_values, num_of_diff_l_values*(i-1) + j)
        plot(1:lArray(randj(j),1),alpha_array{randj(j),i})
        hold on 
        plot(1:lArray(randj(j),1),beta_array{randj(j),i})
        title(['f' num2str(i) ' (x) and l = ' num2str(l(randj(j))) ' F'])
        xlabel('k');
        legend('a(k)','b(k)', 'Location', 'Best');
        ylim([alpha_start beta_start]);
        xlim([1 lArray(randj(j),i)]);
        hold off
    end
end


