close all; % Terminate all existing figure dialogs


%% Active Suspension Case Study
% This script includes code and instructions for the active suspension
% portion of the MATLAB case study for ESE 351.

%% Section 1: Open Loop System
% Consider the dynamics outlined in the case study document. Derive the
% transfer function between the input (roadSurface) and the output if the
% piston is perfectly rigid - that is, if it has a transfer function of 1.
% Plot the pole map and note any observations. Is this system stable or
% unstable? What would happen if we used the active suspension without any
% feedback or control?

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

%% Section 2: Closed Loop System
% Examine the piston_controller function in the case study folder. This
% function takes in four arguments - the current road height and the
% current height, velocity, and acceleration of the vehicle body. It
% returns one output - the force that the piston should apply, which can be
% positive or negative. (If it is positive, the piston will attempt to
% expand. If it is negative the piston will attempt to contract.)

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


num = {[k] [1]}
den = {[m k c]}
H = tf(num, den)


% 
% y = zeros(size(t));
% vel = zeros(size(t));
% accel = zeros(size(t));
% 
% for i = 1:length(t)-1
%     accel(i+1) = 1/m*piston_controller(roadSurface(i), y(i), vel(i), accel(i));
%     vel(i+1) = vel(i)+accel(i)*dt;
%     y(i+1) = y(i) + vel(i)*dt + roadSurface(i+1)-roadSurface(i);
% end


%% Visualize the results

% This chunk plots the displacement of the road and the car alongside each
% other. How well does the system eliminate potholes and noise?
figure("Name","Suspension system plot");
hold on;
plot(t,y+.17) %Replace y with the output of your simulation
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
animateCar(y, roadSurface, v, dt, T); %Replace y with the output of your simulation
hold off;