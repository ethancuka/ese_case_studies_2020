% Curious how the encode and decode functions for this lab work? The answer
% is suprisingly simple. Here's the function that turns the received signal
% back into the original message. If you're having trouble picturing some
% of the steps, try adding commands to plot each stage of the decoding
% process.

function message = decode(r, pulse_shape, sampleRate, symbolRate, figurePlotting)
% Our decoder has to know how much time it should expect to wait between
% each pulse. Since it works in discrete time using samples instead of
% seconds, this line tell it how many samples it should expect to see
% between each pulse.
samplesPerSymbol = symbolRate/sampleRate;

%This is the key line that all our conversations about orthoganality have
%been building up to. Because our pulse shape is orthogonal to
%time-delayed versions of itself, when we convolve the signal with the
%pulse shape, it essentially filters out all the past and future pulses. No
%matter how much the pulses overlap, this line will allow our receiver to
%seperate them out again. Feel free to add a line to plot the results of
%this command and compare what comes out of it to the original signal, as
%well as to the original symbol stream your encoder created.
filtered = flip(filter(pulse_shape,1,flip(r)));

if figurePlotting
   figure;
   plot(filtered)
   title("Output of Match Filter")
end

% Just like we had to upsample from symbol time to sample time, we now have to
% downsample. In a more sophisticated model, we must consider timing
% issues; what if the transmitter and receiver are offset by a few samples,
% for instance? However, in our toy model,
downsampleSig = filtered(1:samplesPerSymbol:end);

if figurePlotting
   figure;
   plot(upsamp)
   title("Downsampled Symbol-Sequence")
end

% Since we mapped a positive amplitude to 1 and a negative amplitude to 0,
% the code to determine which bit was sent based on what symbol was
% received is very easy:
decision = downsampleSig>0;

% The convolution process adds some extra samples that we don't want. Our
% bitstream has to be a multiple of 7 in order to be converted back to
% ASCII.
trim = 7*floor(length(decision)/7);

% This line simply converts the resulting bitstream back to ASCII.
message = binvector2str(decision(1:trim));
end