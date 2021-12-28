%%  Optimization Techniques
%   2nd assignement 07-12-21 plotting f(x,y) (task 1)

function plotting (X, Y, f, figureNumber)

% function to plot f(x,y) using surface and contour plot, so to have a
% better overview of it

x = -4:0.1:4;  % define range and mesh of x and y which will be shown in figure
y = -4:0.1:4;
z = f(X,Y);

%%
figure(figureNumber);
figureNumber = figureNumber + 1;
clf
surfc(X, Y, z);
grid off;
colorbar
view(20, 25)
title('$z = f(x,y) = x^{3}e^{-x^2-y^4}$', 'Interpreter', 'latex');
xlabel('x')
ylabel('y')
zlabel('z')
%%
figure(figureNumber);
figureNumber = figureNumber + 1;
clf
imagesc(z)
colormap(jet);
colorbar
grid
%%
figure(figureNumber);
figureNumber = figureNumber + 1;
clf
hold on;
planeimg = abs(z);

% get the corners of the domain in which the data occurs.
min_x = min(min(x));
min_y = min(min(y));
max_x = max(max(x));
max_y = max(max(y));
 
% scale image between [0, 255] in order to use a custom color map for it.
minplaneimg = min(min(planeimg)); % find the minimum
scaledimg = (floor(((planeimg - minplaneimg) ./ ...
    (max(max(planeimg)) - minplaneimg)) * 255)); % perform scaling
%convert the image to a true color image with the jet colormap.
colorimg = ind2rgb(scaledimg,jet(256));
surf(x,y,z,'edgecolor','none');
colormap(gray);
surf([min_x max_x],[min_y max_y],repmat(-0.7, [2 2]),...
    colorimg,'facecolor','texture')
colorbar
grid on;
view(-50,20);
title('$z = f(x,y) = x^{3}e^{-x^2-y^4}$', 'Interpreter', 'latex');
xlabel('x');
ylabel('y');
zlabel('z');
end
