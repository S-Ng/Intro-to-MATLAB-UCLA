% Circle-circle Intersection Area Calculator
% Clean MATLAB workspace
clear all;
clc;

% DEFINITIONS OF VARIABLES
% x1: x coordinate of first circle
% y1: y coordinate of first circle
% r1: radius of first circle
% x2: x coordinate of second circle
% y2: y coordinate of second circle
% r2: radius of second circle

% Solicit user-input for all variables
fprintf('Circle-circle Intersection Area Variables\n')
x1 = input('Please enter a value for the x coordinate of the first circle, x1: ');
y1 = input('Please enter a value for the y coordinate of the first circle, y1: ');
r1 = input('Please enter a value for the radius of the first circle, r1: ');
x2 = input('Please enter a value for the x coordinate of the second circle, x2: ');
y2 = input('Please enter a value for the y coordinate of the second circle, y2: ');
r2 = input('Please enter a value for the radius of the second circle, r2: ');

% Assign d, the distance between centers of circles
    d1 = (x1-x2)^2;
    d2 = (y1-y2)^2;
d = sqrt(d1+d2);

% Assign c, the chord length where the circles intersect
    c1 = (-d+r1+r2);
	c2 = (d-r1+r2);
	c3 = (d+r1-r2);
	c4 = (d+r1+r2);
c = (1/d)*sqrt(c1*c2*c3*c4);

% Assign Area, the area of the intersection
        a1 = (d^2+r1^2-r2^2);
        a2 = (2*d*r1);
    a3 = r1^2*acos(a1/a2);
        a4 = (d^2-r1^2+r2^2);
        a5 = (2*d*r2);
    a6 = r2^2*acos(a4/a5);
    a7 = (d/2)*c;
Area = a3+a6-a7;

% Print variables and Area
fprintf('\n')
fprintf('x1 = %5.2f\n',x1)
fprintf('y1 = %5.2f\n',y1)
fprintf('r1 = %5.2f\n',r1)
fprintf('x2 = %5.2f\n',x2)
fprintf('y2 = %5.2f\n',y2)
fprintf('r2 = %5.2f\n\n',r2)
fprintf('Area = %7.4f\n',Area)

