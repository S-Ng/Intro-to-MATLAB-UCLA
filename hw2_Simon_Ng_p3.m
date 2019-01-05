% CLASSIFYING CUBIC FUNCTIONS
% This script classifies cubic functions as monotone, simple, or not simple
% Simon Ng
% UID: 304993160

% CLEAN UP MATLAB WORKSPACE
clear all;
clc;

% REQUEST, TEST, AND PRINT USER-INPUT FOR COEFFICIENTS OF CUBIC

% Request inputs
fprintf('CUBIC FUNCTION CLASSIFIER FOR q(x)=ax^3+bx^2+cx+d\n')
a = input('Please enter a value for a: ');
    % Test that a does not equal 0
    if a == 0
      error('Please enter a non-zero value for a.')
    end
b = input('Please enter a value for b: ');
c = input('Please enter a value for c: ');
d = input('Please enter a value for d: ');

% Print inputs
fprintf('\na = %10.6f\n', a)
fprintf('b = %10.6f\n', b)
fprintf('c = %10.6f\n', c)
fprintf('d = %10.6f\n', d)

% CLASSIFY DERIVATIVE OF q(x), qprime(x), AS MONOTONE, SIMPLE, OR NOT SIMPLE

% Find coefficients of qprime(x): qprime(x)=3*ax^2+2*bx+c
aprime = 3*a;
bprime = 2*b;

% Find discriminant of qprime(x)
D = bprime^2 - 4*aprime*c;

% Test if qprime(x) is montone (no distinct real roots)
    % D > 0 : distinct real roots
    % D = 0 : repeated real roots
    % D < 0 : complex roots
if D <= 0
    fprintf('\nMonotone\n')
else % Decide whether q(x) is simple or not simple
% Find roots of qprime(x)
r1 = (-bprime + sqrt(D))/(2*aprime);
r2 = (-bprime - sqrt(D))/(2*aprime);

% Find q(r1) and q(r2)
q_of_r1 = a*r1^3 + b*r1^2 + c*r1 + d;
q_of_r2 = a*r2^3 + b*r2^2 + c*r2 + d;

% Print r1, q(r1), r2, and q(r2)
fprintf('\nr1 = %10.6f\n', r1)
fprintf('q(r1) = %10.6f\n', q_of_r1)
fprintf('r2 = %10.6f\n', r2)
fprintf('q(r2) = %10.6f\n', q_of_r2)

% Test for simplicity and print result
    if q_of_r1*q_of_r2 < 0
        fprintf('Function q is simple.\n')
    else
        fprintf ('Function q is NOT simple.\n')
    end
end

