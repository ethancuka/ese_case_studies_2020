%% MATLAB code for ESE-351 Homework 1
close all;
%% Discrete and Continuous Functions

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

%% Difference Equations and Continuous Equations

% Method 1: Continuous simulation
t = (0:.01:10-.01);
signal = double(t>=2);
output = lsim(tf(1, [1 1]),signal,t);

% Method 2: Difference equation simulation

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

% Plot and compare results

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%
%% Response of Two RC Circuits
T = 1.5;       % Sim duration, seconds
dT = 44100;    % Sample rate, Hz
R = 10;        % Resistance, Ohms
C = 50e-6;     % Capacitance, Farads



t = (0:1/dT:T-1/dT);     % Time vector
signal = sin(2*pi*1000*t); % Your code here

% Circuit 1 simulation
out1 = lsim(tf(1, [R*C 1]),signal,t);
outTest = lsim([1/(R*C),[1, 1/(R*C)]], signal, t);

% Circuit 2 simulation
out2 = lsim(tf([R*C 0], [R*C 1]),signal,t);

figure;
hold on;
plot(t,out1-outTest)