T = 3 %Simulation duration

%% Set circuit parameters
%Circuits 1 and 2
    %Cutoff = 80 Hz
R = 1000
C = 2e-6


%Circuit 3
    %Low cutoff = 200 Hz
    %High cutoff = 2.5 kHz
R_1 = 320
C_1 = 2e-7

R_2 = 400
C_2 = 2e-6

%% Load external sound files
% For best results, use audio sampled at 44100 Hz.

% Your audio here
[audio_timeseries, Fscustom] = sound2ts("evillaugh.wav", T, false);
% Logarithmic chirp sample
[chirp_timeseries, Fs] = sound2ts("chirp.wav", T, false);

if ~(Fscustom==Fs)
    warning("Custom audio sample rate does not match native sample rate. This may cause errors or distortion. For best results, use a mono audio file sampled at 44100 Hz")
end