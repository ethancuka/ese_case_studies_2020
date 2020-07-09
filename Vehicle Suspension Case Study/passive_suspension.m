close all; % Terminate all existing figure dialogs


%% Passive Suspension Case Study
% This script includes code and instructions for the passive suspension
% portion of the MATLAB case study for ESE 351.
%
% Created by Ethan Cuka for the McKelvey School of Engineering at
% Washington University in St. Louis
% Last updated: 7/8/2020


%% Section 1: Model
% Consider a 2000 kg car traveling along a bumpy road. The wheels are rigid
% and flush with the road, but the body of the car "floats" above the
% wheels, suspended by a damped oscillator with spring constant |k| and
% damping coefficient |c|. For simplicity, assume the car's mass is evenly
% distributed between each spring and that each suspension system is
% independent. Essentially, the resulting system is a damped oscillator
% attached to a mass of 500 kg which has the input-output equation shown in
% the case study document

% Your goal for this first section is to simulate this input-output
% equation by modeling it as a transfer function. Using the parameters
% below and the tf() and lsim() commands, create and simulate the system.
% Use the vector roadSurface as the input to your system. Use the
% pre-written plots and animateCar() functions or create your own to
% visualize the results of your simulation.

%% Simulation Parameters:
% Sim works best if T/dt is an integer
dt = .01;                 % Simulation interval in seconds 
T = 20;                   % Simulation length in seconds
t = linspace(0, T, T/dt)';% Time vector for simulation
v = 18;                   % Vehicle speed in m/s
bumpiness = 2;            % Amplitude of road noise in cm
pothole_depth = 6;        % Depth of potholes in cm
pothole_width = 50;       % Width of potholes in cm
roadSurface = generateTerrain(T, dt, v, bumpiness, pothole_depth, pothole_width);

%% System Properties
m = 500;                  % Weight placed on a particular wheel in kg
k = 100000;               % Spring constant of suspension in N/m
c = 5000;                 % Damping coefficient of suspension in Ns/m

%% Simulation

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

%% Visualize the results

% This chunk plots the displacement of the road and the car alongside each
% other. How well does the system eliminate potholes and noise?
figure("Name","Suspension system plot");
hold on;
plot(t, y+.17) %Replace y with the output of your simulation
plot(t, roadSurface+(pothole_depth+1)*.01)
ylim([0,.25])
legend(["Car Body", "Road Surface"])
ylabel("Displacement (meters)")
xlabel("Time (s)")
hold off;

% This chunk of code animates the sim results. If you're having trouble
% seeing the effect of bumps on your simulation, consider multiplying your
% output vector by a scalar to make perturbations appear bigger.
figure;
hold on;
animateCar(y, roadSurface, v, dt, T); %Replace y with the output of your simulation
hold off;

%% Section 2: Experimentation
% Using the transfer function you derived in the previous section, plot the poles and zeros
% of the system. Now's your chance to play with this
% system: Change the values of |m|, |k|, and |c| and observe the effect on
% the transfer function and pole map. Also observe any relationships
% between the behavior of your simulation and the location of poles and
% zeroes. What happens as poles move further left? What happens as they
% move closer to the real axis? Be sure to record these and any other
% observations in your writeup!

% Hint: You may find the tf() and pzmap() functions to be very useful.

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

%% Section 3: Case Study
% Consider a heavy-duty pickup truck with a mass of 3000 kg that can 
% hold up to 1000 kg of passengers and cargo. Devise values of |k| and |c|
% which absorb shocks and vibrations for both the loaded and unloaded
% truck. For each case, simulate the result, derive the transfer function,
% and plot the pole map as you did previously. Construct visualizations of
% each model and compare the results. (You may use the animateCar()
% function from before.)

% Remember to divide the mass by 4 for both cases, as we assume 
% each wheel suspends 1/4th of the entire truck, and our simulation only
% models a single wheel.

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%
