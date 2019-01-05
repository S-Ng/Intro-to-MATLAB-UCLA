% SIMPLE PENDULUM
% Simon Ng
% UID: 304993160

% Clear MATLAB Workspace
clear all;
clc;

% Define Constants and Time Variables
g = 9.81;
L = 1;
dt = 0.005;
tFinal = 20;
N = ceil(tFinal/dt) + 1;
Nminus1 = N-1;
time = linspace(0,tFinal,N);

% Make Empty Arrays
theta = zeros(N, 1);
omega = zeros(N, 1);
alpha = zeros(N, 1);
h = zeros(N, 1);
energyPerMass = zeros(N, 1);

% Initialize First Vector Entries
theta(1,1) = pi/3;
omega(1,1) = 0;
alpha(1,1) = 0;
h(1,1) = L*(1-cos(theta(1,1)));
energyPerMass(1,1) = g*h(1,1)+1/2*(L*omega(1,1))^2; 

% Calculate and Store Theta, Omega, Alpha, h, and Energy
for k = 1:Nminus1
    
    omega(k+1) = -g/L*sin(theta(k))*dt+omega(k);
    theta(k+1) = theta(k)+omega(k)*dt;
    alpha(k+1) = (omega(k+1)-omega(k))/dt;
    h(k+1) = L*(1-cos(theta(k)));
    energyPerMass(k) = g*h(k+1)+1/2*(L*omega(k)).^2;
    
end

% Plot Position, Velocity, and Acceleration
figure
plot(time, alpha, time, omega, time, theta)
legend('Acceleration (rad/s^2)', 'Velocity (rad/s)', 'Position (rad)');
xlabel('Time (s)')
ylabel('Kinematic Equations')
title('Angular Position of a Pendulum over Time')
axis([0 20 -3*pi 3*pi])

% Plot Energy
figure
plot(time, energyPerMass)
xlabel('Time (s)')
ylabel('Total Energy per Mass (J/kg)')
title('Energy of Simple Pendulum')
