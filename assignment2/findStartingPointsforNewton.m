%%  Optimization Techniques
%   2nd assignement 07-12-21 extra function to find points where the 
%   Hessian matrix is positive definite, so as Newton's Method can find the minimum


function findStartingPointsforNewton(X,Y,f,z,gradf,hessianf,figureNumber, selectGamma)
    %%
    howManyGoodPoints = 0;
    goodPoints = [];
    for q =1:40
        for p = 1:40
            xPoint = -2 + 0.1*q;
            yPoint = -2 +0.1*p;
            try chol(hessianf(xPoint, yPoint));
                %fprintf('x,y = (%f, %f)\n', xxxx, yyyy);
                [~, ~, k, ~] = NewtonMethod(xPoint, yPoint, f, gradf, hessianf, 0.00001, selectGamma);
                %disp('Matrix is symmetric positive definite.')
               if k >5

                    howManyGoodPoints = howManyGoodPoints +1;
                    goodPoints(howManyGoodPoints, :) = [xPoint;yPoint];
               end
                %disp(howManyGoodPoints);
            catch ME
            end
        end
    end

%%
figure(figureNumber);
    clf
    figureNumber = figureNumber + 1;
    hold on
    %title(['point where the Hessian matrix is positive definite and Newton''s Method can be used'], 'Interpreter', 'latex')
    contour(X,Y,z);
    colorbar
    scatter(-1, -1, 'r');
    scatter(goodPoints(:,1), goodPoints(:,2),'filled');
    xlim([-2, 2])
    ylim([-2, 2])
    xlabel('x') 
    ylabel('y')
end
