close all; % Terminate all existing figure dialogs


%% Passive Suspension Case Study
% This script includes code and instructions for the passive suspension
% portion of the MATLAB case study for ESE 351.


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
% equation in a manner of your choice. The vector roadSurface will act as
% the discretely sampled input to your system and represents the height of
% the road relative to an arbitrary reference point. Your simulation should
% output another vector, of the same length as roadSurface, that contains
% the height of the vehicle body relative to the same arbitrary reference
% point. (See the diagram in the case study document)

% Some ideas for how to execute this:
% -Use ode45, a differential equation solver. See the documentation on
%   ode45 for how to solve second-order systems.
% -Simulate each timestep of the simulation manually using an euler
%   approximation or other discrete method.
% -Convert the input-output equation to a state-space model and use lsim()
% -Express the system as a transfer function and use Simulink

% Important: Neglect gravity.

%% Simulation Parameters:
% Sim works best if T/dt is an integer
dt = .01;                 % Simulation interval in seconds 
T = 20;                   % Simulation length in seconds
t = linspace(0, T, T/dt)';% Time vector for simulation
v = 18;                   % Vehicle speed in m/s
m = 500;                  % Weight placed on a particular wheel in kg
k = 300;                  % Spring constant of suspension in N/m
c = 1;                    % Damping coefficient of suspension in Ns/m

bumpiness = 1;            % Amplitude of road noise in cm
pothole_depth = 5;        % Depth of potholes in cm
pothole_width = 50;       % Width of potholes in cm

%Use this as the input for the input-output equation
roadSurface = generateTerrain(T, dt, v, bumpiness, pothole_depth, pothole_width);

%% Simulation

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

% Sample implementation
% % Construct state space model
% A = [0, 1; -k/m, -c/m];
% B = [0;k/m];
% C = [1,0];
% D = [0];
% 
% x = x0;
% y = zeros(T/dt,1);
% N = T/dt;
% for i = 1:N
%     y(i) = C*x + D*r(i);
%     x = A*x + B*r(i);
% end

%% Visualize the results


% This chunk plots the displacement of the road and the car alongside each
% other. How well does the system eliminate potholes and noise?
figure("Name","Suspension system plot");
hold on;
plot(y+.17) %Replace y with the output of your simulation
plot(r+(pothole_depth+1)*.01)
ylim([0,.25])
legend(["Car Body", "Road Surface"])
ylabel("Displacement (meters)")
xlabel("Time (s)")
hold off;

% This chunk of code animates the sim results
figure;
hold on;
animateCar(y, roadSurface, v, dt, T); %Replace y with the output of your simulation
hold off;

%% Section 2: Experimentation
% Use the input-output equation shown in the case study document to
% determine the transfer function of the system. Plot the poles and zeros of
% the transfer function below. Now's your chance to play with this system:
% Change the values of |m|, |k|, and |c| and observe the effect on the
% transfer function and pole map. Also observe any relationships between
% the behavior of your simulation and the location of poles and zeroes.
% What happens as poles move further left? What happens as they move closer
% to the real axis? Be sure to record these and any other observations 
% in your writeup!

% Hint: You may find the tf() and pzmap() functions to be very useful.

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

%% Section 3: Case Study
% Consider a heavy-duty pickup truck with a mass of 3000 kg that can 
% hold up to 1000 kg of passengers and cargo. Devise values of |k| and |c|
% which absorb shocks and vibrations for both the loaded and unloaded
% truck. For each case, simulate the result, derive the transfer function,
% and plot the pole map as you did previously.

% Remember to divide the mass by 4 for both cases, as we assume 
% each wheel suspends 1/4th of the entire truck.

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%
