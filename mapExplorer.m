%{
Michael Gee
ITP 168 Fall 2021
Homework 5
mpgee@usc.edu
%}
clear;clc
% Part 1:
% validInput is the condition used to repeat while loop until valid input
% is given.
validInput = 0;
% while loop used to repeat getting input until valid file name is given
while validInput == 0
    % get input for file name
    fileName = input("Enter a file name: ", 's');
    % isfile() used to check if input is a file present in MATLAB
    % isfile() returns a boolean (1 if file is present in MATLAB or 0 if file is not
    % present).
    if isfile(fileName) == 1
        % isfile(fileName) == 1 means fileName is present in MATLAB
        validInput = 1;
        % validInput = 1 ends the while loop
    else
        % if isfile(fileName) ~= 1, then the input is not a file present in
        % MATLAB
        fprintf("File name not found. Please try again\n")
        % user is told their input is not a valid file and the while loop
        % repeats
    end
end

% the dimensions for the arrays are degined using importdata(fileName)
% assigning each dimension to elements in the first row of the data
dimensions = importdata(fileName);
m = dimensions(1,1); % num of rows in final array
n = dimensions(1,2); % num of columns

% dlmread() reads the data and splits each value at ' '.
data = dlmread(fileName, ' ');

% second row and onward - three column vectors: long, lat, and elev
long = data(2:length(data), 1); % longitude
lat = data(2:length(data), 2); % latitude
elev = data(2:length(data), 3); % elevation

% reshape column vectors into same sized arrays using reshape(). dimensions 
% of reshaped arrays are given by first row of file.
long = reshape(long, [m ,n]);
lat = reshape(lat, [m ,n]);
elev = reshape(elev, [m ,n]); 

% call on exploremat and pass long, lat, and elev through it.
exploremap(long, lat, elev)

