R = 1000
C = 2e-6

R_1 = 320
C_1 = 2e-7


R_2 = 400
C_2 = 2e-6





% Load Chirp
[chirp, Fs] = audioread("chirp.wav");
t = linspace(0,3,length(chirp));
chirp_timeseries = timeseries(chirp,t)