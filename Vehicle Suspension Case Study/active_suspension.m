close all; % Terminate all existing figure dialogs


%% Active Suspension Case Study
% This script includes code and instructions for the active suspension
% portion of the MATLAB case study for ESE 351.
% 
% Created by Ethan Cuka for the McKelvey School of Engineering at
% Washington University in St. Louis
% Last updated: 7/8/2020

%% Section 1: Open Loop System
% Consider the dynamics outlined in the case study document. Derive the
% transfer function between the input (roadSurface) and the output if the
% piston applies no force. Analyze the system's pole map. Is the system
% stable? How can you tell? Record your observations in your writeup.

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

%% Section 2: Closed Loop System
% Examine the piston_controller function in the case study folder. This
% function takes in three arguments - the height, velocity, and
% acceleration of the vehicle body. It returns one output - the force that
% the piston should apply, which can be positive or negative. (If it is
% positive, the piston will attempt to expand. If it is negative the piston
% will attempt to contract.)

% Write your own piston_controller function and test it using the code
% below.

%% Simulation parameters
dt = .01;                 % Simulation interval in seconds 
T = 20;                   % Simulation length in seconds
t = linspace(0, T, T/dt)';% Time vector for simulation
v = 18;                   % Vehicle speed in m/s
m = 500;                  % Weight placed on a particular wheel in kg

bumpiness = 1;            % Amplitude of road noise in cm
pothole_depth = 5;        % Depth of potholes in cm
pothole_width = 50;       % Width of potholes in cm

roadSurface = generateTerrain(T, dt, v, bumpiness, pothole_depth, pothole_width);

%% System Properties
m = 500;                  % Weight placed on a particular wheel in kg
k = 100000;               % Spring constant of suspension in N/m
c = 5000;                 % Damping coefficient of suspension in Ns/m

%% Simulation

%Form time and state vectors
t = linspace(0, T, T/dt);
x = zeros(4, length(t));
for i = 1:length(t)-1
%Calculate piston force
x(4, i+1) = piston_controller(x(1,i), x(2,i), x(3,i));
%Calculate acceleration
x(3, i+1) = 1/m*(-k*(x(1,i)-roadSurface(i)) - c*x(2, i) + x(4, i+1));
%Calculate velocity
x(2, i+1) = x(2,i) + x(3,i)*dt;
%Calculate position
x(1, i+1) = x(1,i) + x(2,i)*dt;
end

y = x(1,:);
%% Visualize the results

% This chunk plots the displacement of the road and the car alongside each
% other.
figure("Name","Suspension system plot");
hold on;
plot(t,y+.17)
plot(t,roadSurface+(pothole_depth+1)*.01)
ylim([0,.25])
legend(["Car Body", "Road Surface"])
ylabel("Displacement (meters)")
xlabel("Time (s)")


% This chunk of code animates the sim results. If you're having trouble
% seeing the effect of bumps on your simulation, consider multiplying your
% output vector by a scalar to make perturbations appear bigger.
figure;
hold on;
animateCar(y, roadSurface, v, dt, T);
hold off;


%% Analysis
% How well did your controller improve the performance of the suspension
% system? Test your controller by changing the mass of the vehicle as you
% did in the passive suspension case study. Does the controller work well
% for both a loaded and unloaded vehicle? Record observations and plots in
% your write-up.

%% Closed-Loop Transfer Function
% Calculate the transfer function of your piston controller and find a way
% to combine it with the open-loop transfer function to derive the full,
% closed-loop transfer function. Plot the poles and zeros. Record your
% observations in your writeup.

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

%% Stability
% What happens if you reverse the blah blah blah TODO