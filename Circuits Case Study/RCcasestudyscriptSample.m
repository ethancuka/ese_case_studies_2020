%% MATLAB script for Circuits case study
% This script contains everything you'll need for the MATLAB portion of the
% RC circuits case study. 


close all;  % Close existing figure dialogs
%% Set simulation parameters
T = 3;      % Simulation duration
dT = 44100; % Sample rate

%% Set circuit parameters
%Circuits 1 and 2
R = 1000;
C = 2e-6;

%Circuit 3
R_1 = 320;
C_1 = 2e-7;
R_2 = 400;
C_2 = 2e-6;

% Define circuit transfer functions
circuit1 = tf(1, [R*C 1]);
circuit2 = tf([R*C 0], [R*C 1]);
circuit3 = tf(1, [R_1*C_1 1])*tf([R_2*C_2 0], [R_2*C_2 1]);

%% Load external sound files
% For best results, use audio sampled at 44100 Hz.

% Your audio here
[audio_timeseries, Fscustom] = sound2ts("evillaugh.wav", T, false);
% Logarithmic chirp sample
chirp = audioread("chirp.wav");

%% Simulation
% Construct input signal
t = (0:1/dT:(T-1/dT));  % Time vector
f = 1;
signal = chirp(1:length(t)); % A simple 100Hz sine wave
% Simulate results
c1out = lsim(circuit1, signal, t);
c2out = lsim(circuit2, signal, t);
c3out = lsim(circuit3, signal, t);
% Show results
figure("Name", "Time Series");
subplot(2,2,1), plot(t,signal), title("Original Signal")
ax1 = gca;
ylim([-2 2])
subplot(2,2,2), plot(t,c1out), title("Circuit 1 Output")
ax2 = gca;
subplot(2,2,3), plot(t,c2out), title("Circuit 2 Output")
ax3 = gca;
subplot(2,2,4), plot(t,c3out), title("Circuit 3 Output")
ax4 = gca;
linkaxes([ax1 ax2 ax3 ax4],'xy')

yimp = impulse(circuit1, t);
convo = conv(yimp, signal);
figure;
plot(t,convo(1:length(t)))
% Plot PSD
plotPowerSpectrum(signal,Fs)
plotPowerSpectrum(c3out,Fs)

%Plot bode
freqrange = logspace(1,4, 50);
mag = zeros(size(freqrange));
%phase = zeros(size(freqrange));
for f = 1:length(freqrange)
    signal = sin(2*pi*freqrange(f)*t);
    sim = lsim(circuit2,signal,t);
    simtrim = round(length(t)/3); 
    mag(f) = max(sim(simtrim:end))/max(signal(simtrim:end));
end
magdec = 10*log10(mag);
figure;
subplot(2,1,1), semilogx(freqrange,magdec), title("Magnitude") 
%subplot(2,1,2), semilogx(freqrange,phase), title("Phase")

