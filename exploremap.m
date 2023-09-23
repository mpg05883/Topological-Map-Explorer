function exploremap(long,lat,elev)
%EXPLOREMAP Creates an interactive map to explore
% This function will take in the data given by the three arrays, X, Y, and
% Z. They must all be arrays of the same dimensions. It will then plot the
% contour map and a surface map and will allow the user to move about the
% contour map using the WASD keys. The user will quit using the Q key. The
% boundary box should not extend beyond the map edges
% INPUTS
% LONG - Numeric array containing longitude values
% LAT - Numeric array containing latitude values
% ELEV - Numeric array containing elevation values

%{
Michael Gee
ITP 168 Fall 2021
Homework 5
mpgee@usc.edu
%}

%% TODO: WRITE CODE HERE
% define dimensions of the input arrays
m = size(long, 1); % number of rows
n = size(long, 2); % number of columns

% error check size of input arrays
if size(long) ~= [m,n] 
    error("Array is incorrect size. Input arrays must be" + m + "x" + n)
elseif size(lat) ~= [m,n]
    error("Array is incorrect size. Input arrays must be" + m + "x" + n)
elseif size(elev) ~= [m,n]
    error("Array is incorrect size. Input arrays must be" + m + "x" + n)
end

% radius of Earth
radiusOfEarth = 6.371*10^6;

% lat and long values are in degrees - must convert to meters.
% preallocate arrays using zeros function.
longMeters = zeros(m, n); % longMeters = longitude values in meters
latMeters = zeros(m, n); % latMeters = latitude values in meters

% converting values of longitude from degrees to meters using for loop.
for i = 2:n
    longMeters(:,i) = longMeters(:,i-1)+radiusOfEarth*tan(deg2rad(long(:,i)-long(:,i-1)));
    % use deg2rad to convert values from degrees to radians.
end

% cconverting values of latitude from degrees to meters using for loop
for i = 2:m
    latMeters(i,:) = latMeters(i-1,:)+radiusOfEarth*tan(deg2rad(lat(i,:)-lat(i-1,:)));
    % use deg2rad to convert values from degrees to radians.
end

%% Plotting: 
% use subplot to display both graphs on same figure
subplot(1,2,1)

% surface plot created using the values of long and lat in meters
surf(longMeters, latMeters, elev)

% defining surface plot's x, y, and z bounds
% each axis bound is assigned to a variable because they will be changed
% later
lowerX = 0;
upperX =  1.4*10^5;
lowerY = -4*10^4;
upperY = 0;
xlim([lowerX, upperX]);
ylim([lowerY, upperY]);
zlim([-inf inf])

subplot(1,2,2)
% contour plot created using the values of long and lat in meters
contour(longMeters, latMeters, elev);
axis equal

% use hold on to plot the contour plot and box on the same graph
hold on

% creating red box:
% defining corners of box
top = 1;
right = 28;
left = 1; 
bottom = 28;

% create x and y values for box
xBox = longMeters(1,[left, right, right, left, left]);
yBox = latMeters([top, top, bottom, bottom, top], 1); 

plot(xBox, yBox,'red');

hold off

moveSize = 5;
%% don't touch this stuff
set(gcf,'KeyPressFcn',@callback);
set(gcf,'CurrentCharacter','n');
choose = 'n';
while (choose ~= 'q')
    choose = get(gcf,'CurrentCharacter');
    switch choose
        case 's' %the user wants to move south
            %% TODO: WRITE CODE HERE
            % bottom coordinate plus moveSize cannot exceed the number of
            % rows present.
             if bottom+moveSize <= m
                % vertical bounds of the box are shifted south by adding
                % moveSize to top and bottom
                top = top + moveSize;
                bottom = bottom + moveSize;
                % use subplot to display both graphs on same figure
                subplot(1,2,1)
                % surface plot created using the values of long and lat in meters
                surf(longMeters, latMeters, elev)
                lowerY = lowerY - 7895;
                upperY = upperY - 7895;
                xlim([lowerX, upperX]);
                ylim([lowerY, upperY]);
                zlim([-inf inf])
                subplot(1,2,2)
                % contour plot created using the values of long and lat in meters
                contour(longMeters, latMeters, elev);
                axis equal
                subplot(1,2,2)
                % contour plot created using the values of long and lat in meters
                contour(longMeters, latMeters, elev);
                axis equal
                % use hold on to plot the contour plot and box on the same graph
                hold on
                % create x and y values for box
                xBox = longMeters(1,[left, right, right, left, left]);
                yBox = latMeters([top, top, bottom, bottom, top], 1); 
                plot(xBox, yBox,'red');
                hold off
             else
                % if bottom coordinate plus moveSize is going to exceed the number of
                % rows present, the box does not move and the user is told they cannot go more south.
                fprintf("You cannot go any farther south.\n")
            end                     
            %% stop writing code here
        case 'w' %the user wants to move north
            %% TODO: WRITE CODE HERE
            % top coordinate minus moveSize cannot be lower than 0
            if top-moveSize >= 0
                top = top - moveSize;
                bottom = bottom - moveSize;
                % use subplot to display both graphs on same figure
                subplot(1,2,1)
                % surface plot created using the values of long and lat in meters
                surf(longMeters, latMeters, elev)
                lowerY = lowerY + 7895;
                upperY = upperY + 7895;
                xlim([lowerX, upperX]);
                ylim([lowerY, upperY]);
                zlim([-inf inf])
                subplot(1,2,2)
                % contour plot created using the values of long and lat in meters
                contour(longMeters, latMeters, elev);
                axis equal
                subplot(1,2,2)
                % contour plot created using the values of long and lat in meters
                contour(longMeters, latMeters, elev);
                axis equal
                % use hold on to plot the contour plot and box on the same graph
                hold on
                % create x and y values for box
                xBox = longMeters(1,[left, right, right, left, left]);
                yBox = latMeters([top, top, bottom, bottom, top], 1); 
                plot(xBox, yBox,'red');
                hold off
            else
                % if top coordinate minus moveSize is going to be less than 0
                % the box does not move and the user is told they cannot go more south.
                fprintf("You cannot go any farther north.\n")
            end            
            %% stop writing code here
        case 'a' %the user wants to move west
            %% TODO: WRITE CODE HERE
            % left coordinate minus moveSize cannot be lower than 0
            if left-moveSize >= 0
                right = right - moveSize;
                left = left - moveSize;
                % use subplot to display both graphs on same figure
                subplot(1,2,1)
                % surface plot created using the values of long and lat in meters
                surf(longMeters, latMeters, elev)
                lowerX = lowerX - 7500;
                upperX =  upperX - 7500;
                xlim([lowerX, upperX]);
                ylim([lowerY, upperY]);
                zlim([-inf inf])
                subplot(1,2,2)
                % contour plot created using the values of long and lat in meters
                contour(longMeters, latMeters, elev);
                axis equal
                subplot(1,2,2)
                % contour plot created using the values of long and lat in meters
                contour(longMeters, latMeters, elev);
                axis equal
                % use hold on to plot the contour plot and box on the same graph
                hold on
                % create x and y values for box
                xBox = longMeters(1,[left, right, right, left, left]);
                yBox = latMeters([top, top, bottom, bottom, top], 1); 
                plot(xBox, yBox,'red');
                hold off
            else
                % if left coordinate minus moveSize is going to be less than 0
                % the box does not move and the user is told they cannot go more east.
                fprintf("You cannot go any farther east.\n")
            end          
            %% stop writing code here
        case 'd' %the user wants to move east
            %% TODO: WRITE CODE HERE
            % right coordinate plus moveSize cannot exceed the number of
            % columns present.
             if right+moveSize <= n
                right = right + moveSize;
                left = left + moveSize;
                % use subplot to display both graphs on same figure
                subplot(1,2,1)
                % surface plot created using the values of long and lat in meters
                surf(longMeters, latMeters, elev)
                lowerX = lowerX + 7500;
                upperX =  upperX + 7500;
                xlim([lowerX, upperX]);
                ylim([lowerY, upperY]);
                zlim([-inf inf])
                subplot(1,2,2)
                % contour plot created using the values of long and lat in meters
                contour(longMeters, latMeters, elev);
                axis equal
                subplot(1,2,2)
                % contour plot created using the values of long and lat in meters
                contour(longMeters, latMeters, elev);
                axis equal
                % use hold on to plot the contour plot and box on the same graph
                hold on
                % create x and y values for box
                xBox = longMeters(1,[left, right, right, left, left]);
                yBox = latMeters([top, top, bottom, bottom, top], 1); 
                plot(xBox, yBox,'red');
                hold off
             else
                % if right coordinate plus moveSize is going to exceed the number of
                % columns present, the box does not move and the user is told they cannot go more west.
                fprintf("You cannot go any farther west.\n")
            end    
            %% stop writing code here

    end
    set(gcf,'CurrentCharacter','n');
    %% TODO: WRITE CODE HERE
    
    %% stop writing code here
    pause(0.1);
    
end
end

%% don't touch any of this.
function callback(hObject, callbackdata)

end