%% Digital Communications Case Study
% This script includes code and instructions for the digital communications
% case study for ESE 351

% Created by Ethan Cuka for the McKelvey School of Engineering at
% Washington University in St. Louis
% Last updated: 7/8/2020

close all; %Terminate existing figure dialogs

%% Section 1: Pulse Design
% In this section you will construct a pulse shape for sending messages via
% a Pulse Amplitude Modulation system. You can do this in a number of
% ways:
%  - Construct your pulse in the time domain and determine its fourier
%    transform using fft()
%  - Construct your pulse's fourier transform and determine its time domain
%    representation using ifft()
%  - Construct both representations seperately.
% Some starter code has been written for any approach, but feel free to
% erase or rewrite it as necessary.

%% Time Domain Design
% By default, sample rate is set to 1 kHz and symbol rate is set to 1/8
% kHz. You may change these as necessary. This means that every 8ms, the
% transmitter will send another pulse with a new symbol encoded into it. It
% does not necessarily mean the previous pulse will have finished yet: your
% pulse will probably be longer than the symbol period. Pulses will overlap
% with one another, so it is vital that your pulse shape is orthogonal to
% time-delayed versions of itself.

% For best results, ensure that symbol period is an integer multiple of
% sample period so that symbolLength is an integer.
Tsamp = 1/1000;            % Sample period - the time between each sample.
Tsymb = 8/1000;            % Symbol period - the time between each symbol
symbolLength = Tsymb/Tsamp;% The duration, in samples, of each symbol

truncate = 3;              % Your pulse will probably be longer than a 
                           % single symbol period. This determines how many
                           % symbols into the past and future to cut it 
                           % off. Increasing this value will allow you to
                           % make your pulse longer which could increase
                           % the accuracy of your fourier transform.
                           
t = (-truncate*Tsymb:Tsamp:truncate*Tsymb); %Generate time vector

time_pulse = 0.*t; %Your function here.

%% Frequency Domain Design
% You may find the fft() and fftshift() functions useful.
fsamp = 1/Tsamp;    %Frequency resolution
fsymb = 1/Tsymb;    %Frequency range of symbol

% This chunk generates a frequency range that you may find useful.
L = length(t);          % Define signal length
f = fsamp*(0:(L/2))/L;  % Define Frequency range
f =[-flip(f), f];       % Construct 2-sided frequency axis
f(length(f)/2) = [];    % Remove duplicate 0


frequency_pulse = 0.*f; %Your function here

%% Section 2: Analysis

%%% Pulse Shaping Design Notes
% Plot your pulse shape in both the time domain and frequency domain.
% Recall that two of the goals of pulse shaping are to construct a pulse
% which:
% - Occupies a narrow range in the frequency domain
% - Occupies a short duration in the time domain
% How well did your pulse shape accomplish both goals? What challenges and
% trade-offs did you experience?

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

%%% Autocorrelation and Orthogonality
% Compute and plot the autocorrelation function of your pulse shape in the
% time domain. The autocorrelation function is the convolution of the pulse
% with itself. At which points, if any, is it zero? What does that tell you
% about the orthogonality of your pulse with a time-delayed version of
% itself? Record your observations in your writeup.

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

%%% Fourier Transform of the Autocorrelation
% Remember that convolution in the time domain is equivalent to
% multiplication in the frequency domain. Determine the fourier transform
% of the autocorrelation function and compare it to the fourier transform
% of your pulse shape. Plot them below and record your observations in your
% writeup.

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%

%%% The Nyquist Filtering Criteria
% Consider the fourier transform of your pulse shape. Plot the fourier
% transform alongside several copies of it shifted by integer multiples of
% fsymb. Take the superposition of all these plots and comment on the
% results. What does that tell you about the presence of inter-symbol
% interference in your pulse shape? Record your observations in your
% writeup.

shift = round(L*fsymb/fsamp); % If you used the frequency range provided by 
                              % the sample code above, a frequency shift of
                              % fsymb corrosponds to shifting by this many 
                              % samples.

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%
%% Section 3: Sending Messages
% Use the encode() function to convert a message of your choice into a
% digital signal using a binary Pulse Amplitude Modulation scheme. Plot the
% resulting signal. Use the decode() function to convert the resulting
% signal back into a message. Was your message sent correctly? Change the
% amount of noise in the transmitter. How does increasing or decreasing the
% noise affect transmission? Record your observations in your writeup.

message = "Your message here";
noise = .2;             % Change this to modify the amount of noise
enablePlotting = false; % Turn this on to see some of the intermittent 
                        % steps of the encoding and decoding process

r = encode(message, time_pulse, Tsamp, Tsymb, enablePlotting);          % Encode message
r = r + normrnd(0,noise,size(r)) ;                                      % Add noise
received_message = decode(r, time_pulse, Tsamp, Tsymb, enablePlotting); % Decode message

%% Section 4: Optional Extension

%%% Optional Extension: Transmission and Reception
% Send your pulse shape, encoded message, sample rate, and symbol rate to
% another student in the class and ask them to decode your message. Have
% them do the same to you. Did their pulse shape successfully transmit the
% message to you? Does the pulse shape have the desired characteristics?
% (Short duration, narrow frequency representation, orthogonal to
% time-delayed versions of itself?) Record your observations in your writeup.

%%% Optional Extension: Match Filters
% Examine the encode and decode functions included in the case study. Come
% up with an explanation for how each of them works in your own words.
% Record your observations in your writeup.

%%% Optional Extension: Carrier Waves
% Use element-wise multiplication to multiply your pulse shape by a
% high-frequency cosine wave. Examine the fourier transform of the
% resulting waveform. How has it changed? Multiply it a second time with
% the same cosine wave and examine the resulting fourier transform. How
% this might this effect be used to ensure that different signals
% transmitted at the same time do not interfere with one another? Record
% your observations in your writeup.

carrier_frequency = 400;
carrier_wave = cos(carrier_frequency*2*pi*t);

%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE %
%%%%%%%%%%%%%%%%%%