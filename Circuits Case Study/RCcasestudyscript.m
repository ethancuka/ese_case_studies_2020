%% MATLAB script for Circuits case study
% This script performs many of the same functions as the RCcasestudy
% simulink model. Part 
close all;  % Close existing figure dialogs
run init.m; % Initialize resistor and capacitor values and sample rate

%Define transfer functions
circuit1 = tf(1, [R*C 1]);
circuit2 = tf([R*C 0], [R*C 1]);
circuit3 = tf(1, [R_1*C_1 1])*tf([R_2*C_2 0], [R_2*C_2 1]);

% Construct input signal
t = (0:1/Fs:(T-1/Fs));
signal = sin(10*2*pi*t);
signal = chirp_timeseries.data;

% Simulate results
c1out = lsim(circuit1, signal, t);
c2out = lsim(circuit2, signal, t);
c3out = lsim(circuit3, signal, t);

% Show results
figure("Name", "Time Series");
subplot(2,2,1), plot(t,signal), title("Original Signal")
ax1 = gca;
subplot(2,2,2), plot(t,c1out), title("Circuit 1 Output")
ax2 = gca;
subplot(2,2,3), plot(t,c2out), title("Circuit 2 Output")
ax3 = gca;
subplot(2,2,4), plot(t,c3out), title("Circuit 3 Output")
ax4 = gca;
linkaxes([ax1 ax2 ax3 ax4],'xy')

% Plot PSD
plotPowerSpectrum(signal,Fs)
plotPowerSpectrum(c3out,Fs)
