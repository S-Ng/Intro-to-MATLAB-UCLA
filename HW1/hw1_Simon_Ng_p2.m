% Ellipse Perimeter Approximations Comparison
% Clear MATLAB workspace
clear all;
clc;

% Assign a and b in ellipse equation, (x/a)^2+(y/b)^2=1
fprintf('Ellipse Perimeter Approximation Generator based on ellipse equation (x/a)^2+(y/b)^2=1 \n')
a = input('Please enter a value for a: ');
b = input('Please enter a value for b: ');

% Assign h, an equation to denote the ellipse's deviation from a circle
h = ((a-b)/(a+b))^2;

% Calculate approximations for ellipse perimeters P1 through P8
P1 = pi*(a+b);
P2 = pi*sqrt(2*(a^2+b^2));
P3 = pi*sqrt(2*(a^2+b^2)-(a-b)^2/2);
P4 = pi*(a+b)*(1+h/8)^2;
P5 = pi*(a+b)*(1+3*h/(10+sqrt(4-3*h)));
P6 = pi*(a+b)*(64-3*h^2)/(64-16*h);
P7 = pi*(a+b)*(256-48*h-21*h^2)/(256-112*h+3*h^2);
P8 = pi*(a+b)*(3-sqrt(1-h))/2;

% Print P1 through P8 and h to facilitate comparison
fprintf('P1 = %17.13f\n',P1)
fprintf('P2 = %17.13f\n',P2)
fprintf('P3 = %17.13f\n',P3)
fprintf('P4 = %17.13f\n',P4)
fprintf('P5 = %17.13f\n',P5)
fprintf('P6 = %17.13f\n',P6)
fprintf('P7 = %17.13f\n',P7)
fprintf('P8 = %17.13f\n',P8)
fprintf('h = %f\n',h)
