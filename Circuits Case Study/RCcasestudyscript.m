%% MATLAB script for Circuits case study
% This script contains everything you'll need for the MATLAB portion of the
% RC circuits case study. 


close all;  % Close existing figure dialogs
%% Set simulation parameters
T = 3;                 % Simulation duration in seconds
dT = 44100;             % Sample rate
t = (0:1/dT:(T-1/dT));  % Time vector

%% Set circuit parameters
%Circuits 1 and 2
R = 1000;
C = 2e-6;

%Circuit 3
R_1 = 320;
C_1 = 2e-7;
R_2 = 400;
C_2 = 2e-6;

% Define circuit impulse responses
circuit1 = impulse(tf(1, [R*C 1]),t);       % Generate impulse response for circuit 1
circuit2 = impulse(tf([R*C 0], [R*C 1]),t); % Generate impulse response for circuit 2
circuit3 = impulse(tf(1, [R_1*C_1 1])*tf([R_2*C_2 0], [R_2*C_2 1]),t);  % Generate impulse response for circuit 3
%% Load external sound files
% For best results, use audio sampled at 44100 Hz.

% Your audio here
[audio_timeseries, Fscustom] = sound2ts("evillaugh.wav", T, false);
% Logarithmic chirp sample
chirp = audioread("chirp.wav");

%% Simulation
% For this part of the case study, you'll need to simulate the output of
% each circuit with |signal| as the input using the impulse responses.

f = 100;
signal = sin(f*2*pi*t); % A simple 100Hz sine wave

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%