clear; clc; close all;

%%  Optimization Techniques
%   3nd assignement 20-12-21 main script

%%
f=@(x,y)  0.5*x.^2 + 2*y.^2;
x = -15:0.5:15;  % define range and mesh of x and y which will be shown in figure
y = -20:0.5:12;
[X, Y] = meshgrid(x, y);
z = f(X,Y);
%%
% syms x y;
% f = (0.5*x.^2 + 2*y.^2); 
% g = gradient(f,[x,y])
% e = hessian(f,[x,y])
%%
hessianf  = @(x,y) [1, 0;
                0, 4];

gradf = @(x, y)[x 4*y];
               
%%
selectGamma = [ "constant Gamma", "minimized f(gamma)", "Armijo's Rule"]; 
figureNumber = 1;

%% Task 0 - just plotting...
%plotting(X, Y, f, figureNumber)

%% Task 1 - Steepest Descent Method
% gamma = 0.05;
% [a, g, k, d] = steepestDescentMethod(-7,5,f,gradf,0.02, selectGamma(1), gamma);
% figure(figureNumber);
% figureNumber = figureNumber + 1;
% clf
% surfc(X, Y, f(X,Y));
% hold on;
% plot3(a(:,1),a(:,2),f(a(:,1),a(:,2)), 'r.', 'MarkerSize',24);
% title(['Steepest Descent using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
% grid off;
% colorbar
% view(-70, 60)
% xlabel('x','Interpreter', 'latex')
% ylabel('y','Interpreter', 'latex')
% zlabel('z','Interpreter', 'latex')
% %%
% figure(figureNumber);
% figureNumber = figureNumber + 1;
% plot(a(:,1),a(:,2),'-or')
% hold on
% title(['Steepest Descent using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
% contour(X,Y,z);
% colorbar
% plot(a(:,1),a(:,2),'-or')
% xlim([-1, 1])
% ylim([-1, 1])
% xlabel('x') 
% ylabel('y') 
% axes('Position',[.4 .7 .2 .2])
% axis([-1.228 -1.223 -0.1 -0.07])
% box on
% plot(a(:,1),a(:,2),'-or')
% axis([-0.2 0.2 -0.2 0.2])
% xlabel('x') 
% ylabel('y')
% %%
% figure(figureNumber);
% figureNumber = figureNumber + 1;
% subplot(4,1,1)
% plot(1:k,a(:,1))
% title(['Steepest Descent using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
% xlabel('iterations', 'Interpreter', 'latex') 
% ylabel('x value', 'Interpreter', 'latex')
% subplot(4,1,2)
% plot(1:k,a(:,2))
% title(['Steepest Descent using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
% xlabel('iterations', 'Interpreter', 'latex') 
% ylabel('y value', 'Interpreter', 'latex')
% subplot(4,1,3)
% plot(a(:,1), a(:,2))
% title(['Steepest Descent using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
% xlabel('x value', 'Interpreter', 'latex') 
% ylabel('y value', 'Interpreter', 'latex')
% subplot(4,1,4)
% plot(1:k-1,g)
% title(['Steepest Descent using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
% xlabel('iterations', 'Interpreter', 'latex') 
% ylabel('$\gamma$', 'Interpreter', 'latex')


%% Task 2-3-4 - Steepest Descent with projection
gamma = 0.1;
s = 0.5;
[a, g, k, d] = steepestDescentProjection(17,-5,f,gradf,0.01, gamma,s);
figure(figureNumber);
figureNumber = figureNumber + 1;
clf
surfc(X, Y, f(X,Y));
hold on;
plot3(a(:,1),a(:,2),f(a(:,1),a(:,2)), 'r.', 'MarkerSize',24);
title(['Steepest Descent with projection using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
grid off;
colorbar
view(-70, 60)
xlabel('x','Interpreter', 'latex')
ylabel('y','Interpreter', 'latex')
zlabel('z','Interpreter', 'latex')
%%
figure(figureNumber);
figureNumber = figureNumber + 1;
plot(a(:,1),a(:,2),'-or')
hold on
title(['Steepest Descent with projection using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
contour(X,Y,z);
colorbar
plot(a(:,1),a(:,2),'-or')
xlim([-10, 10])
ylim([-10, 10])
xlabel('x') 
ylabel('y') 
axes('Position',[.4 .7 .2 .2])
axis([-1.228 -1.223 -0.1 -0.07])
box on
plot(a(:,1),a(:,2),'-or')
axis([-0.2 0.2 -0.2 0.2])
xlabel('x') 
ylabel('y')
%%
figure(figureNumber);
figureNumber = figureNumber + 1;
subplot(3,1,1)
plot(1:k,a(:,1))
title(['Steepest Descent with projection using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
xlabel('iterations', 'Interpreter', 'latex') 
ylabel('x value', 'Interpreter', 'latex')
subplot(3,1,2)
plot(1:k,a(:,2))
title(['Steepest Descent with projection using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
xlabel('iterations', 'Interpreter', 'latex') 
ylabel('y value', 'Interpreter', 'latex')
subplot(3,1,3)
plot(a(:,1), a(:,2))
title(['Steepest Descent with projection using $\gamma =$ ' num2str(gamma)], 'Interpreter', 'latex')
xlabel('x value', 'Interpreter', 'latex') 
ylabel('y value', 'Interpreter', 'latex')

