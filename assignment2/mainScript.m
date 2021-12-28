clear; clc; close all;

%%  Optimization Techniques
%   2nd assignement 07-12-21 main script


%%
f=@(x,y)((x.^3).*exp(-x.^2 -y.^4));
x = -4:0.1:4;  % define range and mesh of x and y which will be shown in figure
y = -4:0.1:4;
[X, Y] = meshgrid(x, y);
z = f(X,Y);
%%
% syms x y;
% f = ((x.^3).*exp(-x.^2 -y.^4)); 
% g = gradient(f,[x,y])
% e = hessian(f,[x,y])

%%
hessianf  =@(x,y) [6*x*exp(- x^2 - y^4) - 14*x^3*exp(- x^2 - y^4) + 4*x^5*exp(- x^2 - y^4),  8*x^4*y^3*exp(- x^2 - y^4) - 12*x^2*y^3*exp(- x^2 - y^4);
                8*x^4*y^3*exp(- x^2 - y^4) - 12*x^2*y^3*exp(- x^2 - y^4), 16*x^3*y^6*exp(- x^2 - y^4) - 12*x^3*y^2*exp(- x^2 - y^4)];


gradf = @(x, y)[ 3*x^2*exp(- x^2 - y^4) - 2*x^4*exp(- x^2 - y^4)
                     -4*x^3*y^3*exp(- x^2 - y^4)];
               
%%
selectGamma = [ "constant Gamma", "minimized f(gamma)", "Armijo's Rule"]; 
figureNumber = 1;
%% function to find points where the Hessian matrix is positive definite, so as Newton's Method can find the minimum
%findStartingPointsforNewton(X,Y,f,z,gradf,hessianf,figureNumber,selectGamma(1))


%% Task 1 - just plotting...
% plotting(X, Y, f, figureNumber)

%% Task 2 - Steepest Descent Method
% for i = 1 : length(selectGamma)
%     [a, g, k, d] = steepestDescentMethod(-1,-1,f,gradf,0.0000001, selectGamma(i));
%     figure(figureNumber);
%     figureNumber = figureNumber + 1;
%     clf
%     surfc(X, Y, f(X,Y));
%     hold on;
%     plot3(a(:,1),a(:,2),f(a(:,1),a(:,2)), 'r.', 'MarkerSize',24);
%     title(['Steepest Descent using' selectGamma(i)], 'Interpreter', 'latex')
%     grid off;
%     colorbar
%     view(-90, 10)
%     xlabel('x','Interpreter', 'latex')
%     ylabel('y','Interpreter', 'latex')
%     zlabel('z','Interpreter', 'latex')
%     %%
%     figure(figureNumber);
%     figureNumber = figureNumber + 1;
%     plot(a(:,1),a(:,2),'-or')
%     hold on
%     title(['Steepest Descent using' selectGamma(i)], 'Interpreter', 'latex')
%     contour(X,Y,z);
%     colorbar
%     plot(a(:,1),a(:,2),'-or')
%     xlim([-2, 2])
%     ylim([-2, 2])
%     xlabel('x') 
%     ylabel('y') 
%     axes('Position',[.4 .7 .2 .2])
%     axis([-1.228 -1.223 -0.1 -0.07])
%     box on
%     plot(a(:,1),a(:,2),'-or')
%     axis([-1.4 -1.1 -0.2 0.1])
%     %axis([-1.228 -1.223 -0.1 -0.07])
%     xlabel('x') 
%     ylabel('y')
%     %%
%     figure(figureNumber);
%     figureNumber = figureNumber + 1;
%     subplot(4,1,1)
%     plot(1:k,a(:,1))
%     title(['Steepest Descent using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('iterations', 'Interpreter', 'latex') 
%     ylabel('x value', 'Interpreter', 'latex')
%     subplot(4,1,2)
%     plot(1:k,a(:,2))
%     title(['Steepest Descent using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('iterations', 'Interpreter', 'latex') 
%     ylabel('y value', 'Interpreter', 'latex')
%     subplot(4,1,3)
%     plot(a(:,1), a(:,2))
%     title(['Steepest Descent using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('x value', 'Interpreter', 'latex') 
%     ylabel('y value', 'Interpreter', 'latex')
%     subplot(4,1,4)
%     plot(1:k-1,g)
%     title(['Steepest Descent using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('iterations', 'Interpreter', 'latex') 
%     ylabel('$\gamma$', 'Interpreter', 'latex')
% end

%% Task 3 - Newton's Method
% for i = 1 : length(selectGamma)
%     [a, g, k, d] = NewtonMethod(-1, -1, f, gradf, hessianf, 0.001, selectGamma(i));
%     figure(figureNumber);
%     figureNumber = figureNumber + 1;
%     clf
%     surfc(X, Y, f(X,Y));
%     hold on;
%     plot3(a(:,1),a(:,2),f(a(:,1),a(:,2)), 'r.', 'MarkerSize',24);
%     title(['Newton''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     grid off;
%     colorbar
%     view(-90, 10)
%     xlabel('x','Interpreter', 'latex')
%     ylabel('y','Interpreter', 'latex')
%     zlabel('z','Interpreter', 'latex')
%     %%
%     figure(figureNumber);
%     figureNumber = figureNumber + 1;
%     plot(a(:,1),a(:,2),'-or')
%     hold on
%     title(['Newton''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     contour(X,Y,z);%, 'ShowText','on', 'LevelStep',0.1);
%     colorbar
%     plot(a(:,1),a(:,2),'-or')
%     xlim([-2, 2])
%     ylim([-2, 2])
%     xlabel('x') 
%     ylabel('y') 
%     axes('Position',[.4 .7 .2 .2])
%     axis([-1.228 -1.223 -0.1 -0.07])
%     box on
%     plot(a(:,1),a(:,2),'-or')
%     axis([-1.4 -1.1 -0.2 0.1])
%     %axis([-1.228 -1.223 -0.1 -0.07])
%     xlabel('x') 
%     ylabel('y')
%     %%
%     figure(figureNumber);
%     figureNumber = figureNumber + 1;
%     subplot(4,1,1)
%     plot(1:k,a(:,1))
%     title(['Newton''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('iterations', 'Interpreter', 'latex') 
%     ylabel('x value', 'Interpreter', 'latex')
%     subplot(4,1,2)
%     plot(1:k,a(:,2))
%     title(['Newton''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('iterations', 'Interpreter', 'latex') 
%     ylabel('y value', 'Interpreter', 'latex')
%     subplot(4,1,3)
%     plot(a(:,1), a(:,2))
%     title(['Newton''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('x value', 'Interpreter', 'latex') 
%     ylabel('y value', 'Interpreter', 'latex')
%     subplot(4,1,4)
%     plot(1:k-1,g)
%     title(['Newton''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('iterations', 'Interpreter', 'latex') 
%     ylabel('$\gamma$', 'Interpreter', 'latex')
% end



%% Task 4 - Levenberg's - Marquardt's Method 
% for i = 1 : length(selectGamma)
%     [a, g, k, d] = LevenbergMarquardtMethod(-1, -1, f, gradf, hessianf, 0.0000001, selectGamma(i));
%     figure(figureNumber);
%     figureNumber = figureNumber + 1;
%     clf
%     surfc(X, Y, f(X,Y));
%     hold on;
%     plot3(a(:,1),a(:,2),f(a(:,1),a(:,2)), 'r.', 'MarkerSize',24);
%     title(['Levenberg''s - Marquardt''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     grid off;
%     colorbar
%     view(-90, 10)
%     xlabel('x','Interpreter', 'latex')
%     ylabel('y','Interpreter', 'latex')
%     zlabel('z','Interpreter', 'latex')
%     %%
%     figure(figureNumber);
%     figureNumber = figureNumber + 1;
%     plot(a(:,1),a(:,2),'-or')
%     hold on
%     title(['Levenberg''s - Marquardt''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     contour(X,Y,z);% 'ShowText','on', 'LevelStep',0.1);
%     colorbar
%     plot(a(:,1),a(:,2),'-or')
%     xlim([-2, 2])
%     ylim([-2, 2])
%     xlabel('x') 
%     ylabel('y') 
%     axes('Position',[.4 .7 .2 .2])
%     axis([-1.228 -1.223 -0.1 -0.07])
%     box on
%     plot(a(:,1),a(:,2),'-or')
%     axis([-1.4 -1.1 -0.2 0.1])
%     %axis([-1.228 -1.223 -0.1 -0.07])
%     xlabel('x') 
%     ylabel('y')
%     %%
%     figure(figureNumber);
%     figureNumber = figureNumber + 1;
%     subplot(4,1,1)
%     plot(1:k,a(:,1))
%     title(['Levenberg''s - Marquardt''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('iterations', 'Interpreter', 'latex') 
%     ylabel('x value', 'Interpreter', 'latex')
%     subplot(4,1,2)
%     plot(1:k,a(:,2))
%     title(['Levenberg''s - Marquardt''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('iterations', 'Interpreter', 'latex') 
%     ylabel('y value', 'Interpreter', 'latex')
%     subplot(4,1,3)
%     plot(a(:,1), a(:,2))
%     title(['Levenberg''s - Marquardt''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('x value', 'Interpreter', 'latex') 
%     ylabel('y value', 'Interpreter', 'latex')
%     subplot(4,1,4)
%     plot(1:k-1,g)
%     title(['Levenberg''s - Marquardt''s Method using' selectGamma(i)], 'Interpreter', 'latex')
%     xlabel('iterations', 'Interpreter', 'latex') 
%     ylabel('$\gamma$', 'Interpreter', 'latex')
% end
