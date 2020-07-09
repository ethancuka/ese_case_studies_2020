close all; % Terminate all existing figure dialogs


%% Passive Suspension Case Study SAMPLE IMPLEMENTATION
% This script is a sample implementation of the passive_suspension case
% study assignment


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
k = 200000;               % Spring constant of suspension in N/m
c = 5000;                 % Damping coefficient of suspension in Ns/m

%% Simulation
% In this section we consider two different way to implement the
% simulation, by using lsim() and by manually computing each step in what
% is effectively an implementation of the euler method.

% lsim() method:
num = k;
den = [m,c,k];
transfer = tf(num, den); % Create transfer function
y_1 = lsim(transfer, roadSurface, t); % Use lsim() with roadSurface as input

% Manual method:
x = zeros(3, length(t));
for i = 1:length(t)-1
%Calculate acceleration
x(3, i+1) = 1/m*(-k*(x(1,i)-roadSurface(i)) - c*x(2, i));
%Calculate velocity
x(2, i+1) = x(2,i) + x(3,i)*dt;
%Calculate position
x(1, i+1) = x(1,i) + x(2,i)*dt;
end
y_2 = x(1,:);


%% Comparison
% These two methods of simulation were consistent with one another.
figure;
hold on;
title("Comparison of two simulation methods")
plot(t,y_1)
plot(t,y_2)
legend(["lsim()", "Manual Computation"])
hold off;

y = y_1;
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

%% Sample Solution: Plotting a range of k and c values
%The code below scans through a range of k and c values. Watching the plot
%play out, we can observe that each transfer function associated with k and
%c corrosponds to two poles that are always in the left-half plane,
%indicating a stable system. However, how negative they are, and how
%large their real and imaginary components are, is dependent on k and c

%We can see that increasing c pushes the plot further to the left. For a
%particular value of c, varying k affects whether the poles are real or
%complex, and how far apart they are. For each value of c, there exists
%some critical value of k so that the poles are real, negative, and right
%on top of one another - critical damping.

figure;
cspace = logspace(4,4.5,5);
kspace = logspace(5,6,5);
hold on;
for j = cspace
    for i = kspace
        num = i;
        den = [m,j,i];
        transfer = tf(num, den);
        pzplot(transfer)
        legend("k = " + i + ", c = " + j)
        drawnow
    end
end
hold off
title("Pole Maps for various k and c")

%% Section 3: Case Study
% Consider a heavy-duty pickup truck with a mass of 3000 kg that can hold
% up to 1000 kg of passengers and cargo. In order to support the mass of
% the truck, the spring constant must be at least 200,000 n/m. Devise
% values of |k| and |c| which absorb shocks and vibrations for both the
% loaded and unloaded truck. For each case, simulate the result, derive the
% transfer function, and plot the pole map as you did previously. Construct
% visualizations of each model. Did your system effectively eliminate
% shocks?

% Remember to divide the mass by 4 for both cases, as we assume 
% each wheel suspends 1/4th of the entire truck, and our simulation only
% models a single wheel.

%% Sample Solution: Critical Damping
% Lets say we decide a good way to design our suspension system is to
% ensure it will be critically damped when the truck is half-loaded: 4m =
% 2000 kg -> m = 500kg. For the system to be critically damped, it must
% have two identical real poles at (-c+/-sqrt(c^2-4mk)/2m. We also want our
% poles to have the right magnitude. Too far to the left, and the shocks
% will be too "tight," failing to eliminate perturbances. Too far to the
% right, and the shocks will be too "loose," taking too long to recover
% between perturbances.

% We can use the quadratic formula to determine that the system is
% critically damped when c = sqrt(4mk). By varying k, we can
% see the effect on the "bumpiness" of the suspension. We note that above
% k=200,000 - the minimum k value to ensure the shocks will safely hold up
% the car - the shocks become less effective.
kspace = logspace(5.31, 7, 5);
figure;
hold on;
for i = kspace
    m = 500;
    c = sqrt(4*m*i);
    transfer = tf(i, [250,c,i]);
    y = lsim(transfer, roadSurface, t); % Use lsim()
    plot(t,y)
end
xlim([1,2])
title("Effect of increasing k on shock characteristic")
legend("k="+string(kspace))
hold off;

% Therefore, our final shock design will be:
k = 200000;
c = sqrt(4*k*500);

% Simulate Unloaded Truck
transfer1 = tf(k, [250,c,k]); % Create transfer function
y_1 = lsim(transfer1, roadSurface, t); % Use lsim() with roadSurface as input

% Simulate Loaded truck
transfer2 = tf(k, [750,c,k]); % Create transfer function
y_2 = lsim(transfer2, roadSurface, t); % Use lsim() with roadSurface as input

% Displacement/time plot
figure("Name","Loaded/Unloaded comparison");
hold on;
plot(t, y_1+.17)
plot(t, y_2+.17)
plot(t, roadSurface+(pothole_depth+1)*.01)
ylim([0,.25])
legend(["Unloaded Truck", "Loaded Truck", "Road Surface"])
ylabel("Displacement (meters)")
xlabel("Time (s)")
hold off;

% Animate both suspension systems
figure;
hold on;
title("Unloaded Truck Simulation")
animateCar(y_1, roadSurface, v, dt, T);
hold off;

figure;
hold on;
title("Loaded Truck Simulation")
animateCar(y_2, roadSurface, v, dt, T);
hold off;

% Plot poles
figure;
hold on;
title("Pole Plots")
pzplot(transfer1)
pzplot(transfer2)
legend(["Loaded Truck", "Unloaded Truck"])
hold off;

% Note that because we tuned our suspension system to be critically damped
% for a moderate load, when we plot our poles, we see 2 real poles for the
% heavy load - indicating overdamping - and 2 complex poles for the light
% load - indicating underdamping

% Overall, our method was effective at reducing shocks to the system.