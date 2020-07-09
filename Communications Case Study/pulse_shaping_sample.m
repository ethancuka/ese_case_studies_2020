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
% kHz. This means that every 8/1000 seconds, the transmitter will send
% another pulse. It does not necessarily mean the previous pulse will have
% finished yet: your pulse will probably be longer than the symbol period.

% For best results, ensure that symbol period is an integer multiple of
% sample period.

Tsamp = 1/4000;            % Sample period - the time between each sample.
Tsymb = 8/1000;            % Symbol period - the time between each symbol
symbolLength = Tsymb/Tsamp;% The duration, in samples, of each symbol

truncate = 10;              % Your pulse will probably be longer than a 
                           % single symbol period. This determines how many
                           % symbols into the past and future to cut it 
                           % off.
                           
t = (-truncate*Tsymb:Tsamp:truncate*Tsymb); %Generate time vector


% For simplicity, we will use a truncated sinc function as our pulse shape.
% An Rcos pulse would work better, but most students will likely use a sinc
% function.
time_pulse = sinc(t/Tsymb); %Your function here.

%% Frequency Domain Design
% You may find the fft() and fftshift() functions useful.
fsamp = 1/Tsamp;    %Frequency resolution
fsymb = 1/Tsymb;    %Frequency range of symbol

% This chunk generates a frequency range that you may find useful.
L = length(t);          % Define signal length
f = fsamp*(0:(L/2))/L;  % Define Frequency range
f =[-flip(f), f];       % Construct 2-sided frequency axis
f(length(f)/2) = [];    % Remove duplicate 0


frequency_pulse = abs(fftshift(fft(time_pulse))); %Your function here

%% Section 2: Analysis

%%% Pulse Shaping Design Notes
% Plot your pulse shape in both the time domain and frequency domain.
% Recall that two of the goals of pulse shaping are to construct a pulse
% which:
% - Occupies a narrow range in the frequency domain
% - Occupies a short duration in the time domain
% How well did your pulse shape accomplish both goals? What challenges and
% trade-offs did you experience?

figure;
hold on;
subplot(2,1,1)
plot(t,time_pulse)
title("Time Domain Pulse Shape")
xlabel("Time (s)")
ylabel("Amplitude")
subplot(2,1,2)
plot(f,frequency_pulse)
xlim([-200 200])
title("Frequency Domain Pulse Shape")
xlabel("Frequency (Hz)")
ylabel("|H(f)|")
hold off;

% The chosen pulse shape looks pretty good! While it is somewhat lengthy in
% the time domain, and there is some rolloff in the frequency domain, it
% occupies a fairly reasonable bandwidth, and we truncate it to keep it
% from becoming too lengthy. We can reduce the rolloff and increase
% resolution in the frequency domain by increasing the truncate length.
% This reveals one of our core trade-offs: a pulse that is short in the
% time domain will be wider in the frequency domain.

%%% Autocorrelation and Orthogonality
% Compute and plot the autocorrelation function of your pulse shape in the
% time domain. At which points, if any, is it zero? What does that tell you
% about the orthogonality of your pulse with a time-delayed version of
% itself? Record your observations in your writeup.

autocorrelation = conv(time_pulse, time_pulse, 'same');
figure;
hold on;
plot(t,autocorrelation)
plot(t,zeros(size(t)))
markers = t(1:symbolLength:end);
plot(markers, zeros(size(markers)), 'o')
title("Demonstrating Self-Orthogonality with Autocorrelation")
xlabel("Time (s)")
ylabel("r(t)")
hold off;

% Examining the plot, we can see that the autocorrelation function is zero
% at integer multiples of Tsymb. This suggests that the function is
% orthogonal to version of itself delayed or advanced by a symbol period.
% Therefore, we can use this pulse shape and our receiver will be able to
% seperate out each symbol from the one before and after it.

%%% Fourier Transform of the Autocorrelation
% Remember that convolution in the time domain is equivalent to
% multiplication in the frequency domain. Determine the fourier transform
% of the autocorrelation function and compare it to the fourier transform
% of your pulse shape. Plot them below and record your observations in your
% writeup.

autocorrelation_fft = abs(fftshift(fft(autocorrelation)));
figure;
hold on;
plot(f,frequency_pulse)
plot(f,autocorrelation_fft)
plot(f,frequency_pulse.^2, '--')
title("Comparing Frequency Domains of Pulse and Autocorrelation")
xlim([-200 200])
xlabel("Frequency (Hz)")
legend(["H(f)", "R_f(f)", "H(f)^2"])
hold off;

% From this plot, we can see that the autocorrelation plot's frequency
% domain representation is approximately equal to the square of the pulse
% shape's frequency domain representation. This is because the
% autocorrelation function is essentially the pulse convoluted with itself,
% and convolution in the time domain is equivalent to multiplication in the
% frequency domain.


%%% The Nyquist Filtering Criteria
% Consider the fourier transform of your pulse shape. Plot the fourier
% transform alongside several copies of it shifted by integer multiples of
% fsymb. Take the superposition of all these plots and comment on the
% results. What does that tell you about the presence of inter-symbol
% interference in your pulse shape? Record your observations in your
% writeup.
shift = round(L*fsymb/fsamp);
fft_advance = [zeros(1,shift) frequency_pulse(1:end-shift)]; 
fft_delay = [frequency_pulse(shift+1:end) zeros(1,shift)] ;
figure;
hold on;
plot(f,fft_advance)
plot(f,fft_delay)
plot(f,frequency_pulse)
plot(f,fft_advance+fft_delay+frequency_pulse, 'LineWidth',3)
legend(["Shifted Pulse", "Shifted Pulse", "Original Pulse", "Superposition"])
title("Verifying the Nyquist Filtering Criteria")
xlim([-400 500])
xlabel("Frequency (Hz)")
ylabel("|H(f)|")
hold off;

% From this plot, we can see that our pulse approximately satisfies the
% Nyquist Filtering Criteria. While the jaggedness of our pulse-shape
% causes some issues, we might presume that in continuous time our pulse
% would more closely approximate the desired constant value.

%% Section 3: Sending Messages
% Use the encode() function to convert a message of your choice into a
% digital signal using a binary Pulse Amplitude Modulation scheme. Plot the
% resulting signal. Use the decode() function to convert the resulting
% signal back into a message. Was your message sent correctly? Change the
% amount of noise in the transmitter. How does increasing or decreasing the
% noise affect transmission? Record your observations in your writeup.

message = "I'm the boy mayor of second life, and I think dogs should be able to vote!";
noise = .5;             % Change this to modify the amount of noise
enablePlotting = false; % Turn this on to see some of the intermittent 
                        % steps of the encoding and decoding process

r = encode(message, time_pulse, Tsamp, Tsymb, enablePlotting);          % Encode message
r = r + normrnd(0,noise,size(r)) ;                                      % Add noise
received_message = decode(r, time_pulse, Tsamp, Tsymb, enablePlotting); % Decode message

disp(received_message)

% Our message is sent without error! However, when we start to introduce
% noise, the accuracy of our message falls drastically - characters start
% to get entirely replaced.

% We can compensate for this by increasing the amplitude of our pulse. 
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

%Generate carrier wave
carrier_frequency = 400;
carrier = cos(carrier_frequency*2*pi*t);
%Multiple with pulse
carrier_pulse = time_pulse.*carrier;
%Generate FFT
carrier_fft = abs(fftshift(fft(carrier_pulse)));

figure;
hold on;
subplot(2,1,1)
plot(t,carrier_pulse)
title("Carrier-Encoded Pulse Time Domain")
xlabel("Time (s)")
ylabel("Amplitude")
subplot(2,1,2)
plot(f,carrier_fft)
title("Carrier-Encoded Pulse Frequency Domain")
xlabel("Frequency (Hz)")
ylabel("|H(f)|")
hold off;

% Examining the carrier-encoded pulse, we see that rather than one central
% rectangular pulse centered at f=0, we get two smaller rectangular pulses,
% each centered at +/-f_carrier. This is because element-wise
% multiplication in the time domain is equal to convolution in the
% frequency domain; we have essentially convolved our rectangular pulse
% with the fourier transform of our carrier wave, i.e. two impulses at
% +/-f_carrier.

% We can use this method to transmit several signals with the same pulse
% shape but different carrier frequencies, as they will occupy different
% frequency bands.


% Multiply a second time
pulse_back = carrier_pulse.*carrier;
pulse_back_fft = abs(fftshift(fft(pulse_back)));

figure;
hold on;
subplot(2,1,1)
hold on;
plot(t,time_pulse)
plot(t,pulse_back)
hold off;
title("Time Domain Pulse Shapes")
legend(["Original Pulse", "Pulse after Carrier Modulation"])
xlabel("Time (s)")
ylabel("Amplitude")
subplot(2,1,2)
hold on;
plot(f,frequency_pulse)
plot(f,pulse_back_fft)
hold off;
title("Frequency Domain Pulse Shapes")
legend(["Original Pulse", "Pulse after Carrier Modulation"])
xlabel("Frequency (Hz)")
ylabel("|H(f)|")
hold off;

% Multiplying it through a second time, we have essentially recovered a
% superposition of our waveform and the carrier wave. A low pass filter
% could easily recover just the original pulse shape.