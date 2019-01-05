% This script finds inradius, outradius, and edge length of a series of 
% nested Platonic solids

% Clean up the MATLAB workspace
clear all;
clc;

% DEFINITIONS OF VARIABLES
% R: outradius, r: inradius, E: edge length
% T: the largest tetrahedron that fits inside the unit sphere
% C: the largest cube that fits inside T
% O: the largest octahedron that fits inside C
% D: the largest dodecahedron that fits inside O
% I: the largest iscosahedron that fits inside D
% ex. rD is the inradius of the largest dodecahedron that fits inside O

% Finding RT, ET, and rT from unit sphere
RT = 1;
ET = 4/sqrt(6)*RT;
rT = sqrt(6)/12*ET;

% Finding RC, EC, and rC from rT
RC = rT;
EC = 2/sqrt(3)*RC;
rC = 1/2*EC;

% Finding RO, EO, and rO from rC
RO = rC;
EO = 2/sqrt(2)*RO;
rO = sqrt(6)/6*EO;

% Finding RD, ED, and rD from rO
RD = rO;
ED = 4/(sqrt(15)+sqrt(3))*RD;
rD = sqrt(250+110*sqrt(5))/20*ED;

% Finding RI, EI, and rI from rD
RI = rD;
EI = 4/sqrt(10+2*sqrt(5))*RI;
rI = sqrt(48+18*sqrt(5))/12*EI;

% Print output table of results
fprintf('Geometric Attributes of Nested Platonic Solids\n')
fprintf('\n')
fprintf('Solid        r        R        E\n')
fprintf('Tetrahedron  %8.6f %8.6f %8.6f\n', rT, RT, ET)
fprintf('Cube         %8.6f %8.6f %8.6f\n', rC, RC, EC)
fprintf('Octahedron   %8.6f %8.6f %8.6f\n', rO, RO, EO)
fprintf('Dodecahedron %8.6f %8.6f %8.6f\n', rD, RD, ED)
fprintf('Iscosahedron %8.6f %8.6f %8.6f\n', rI, RI, EI)




