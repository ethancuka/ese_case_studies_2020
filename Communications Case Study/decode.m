% Curious how the encode and decode functions for this lab work? The answer
% is suprisingly simple. Here's the function that turns the received signal
% back into the original message.

function message = decode(r, pulse_shape, samplePeriod, symbolPeriod, figurePlotting)
% Our decoder has to know how much time it should expect to wait between
% each pulse. Since it works in discrete time using samples instead of
% seconds, this line tell it how many samples it should expect to see
% between each pulse.
samplesPerSymbol = symbolPeriod/samplePeriod;

% This is the key line that all our conversations about orthoganality have
% been building up to. Because our pulse shape is orthogonal to
% time-delayed versions of itself, when we convolve the signal with the
% pulse shape, it essentially filters out all the past and future pulses.
% No matter how much the pulses overlap, as long as we have met the
% orthogonality criteria, this line will allow our receiver to seperate
% them out again.
filtered = flip(filter(pulse_shape,1,flip(r)));



% Just like we had to upsample from symbol time to sample time, we now have to
% downsample. In a more sophisticated model, we must consider timing
% issues; what if the transmitter and receiver are offset by a few samples,
% for instance? However, in our toy model,
downsampleSig = filtered(1:samplesPerSymbol:end);

% Since we mapped a positive amplitude to 1 and a negative amplitude to 0,
% the code to determine which bit was sent based on what symbol was
% received is very easy:
decision = downsampleSig>0;

% The convolution process adds some extra junk symbols that we don't want.
% We shave off about one time pulse's worth of junk symbols.
trunc = floor(length(pulse_shape)/samplesPerSymbol);
decision = decision(1:end-trunc);

% We then shave off additional symbols to ensure the resulting bitstream is
% a multiple of 7. This is necessary to translate it into ASCII, as each
% ASCII symbol is 7 bits.
trim = 7*floor(length(decision)/7);

% This line simply converts the resulting bitstream back to ASCII.
message = binvector2str(decision(1:trim));

if figurePlotting
   t = 0:samplePeriod:(length(filtered)-1)*samplePeriod;
   tsamp = (0:length(downsampleSig)-1)*symbolPeriod;
   figure;
   hold on
   plot(t,filtered/max(filtered))
   plot(tsamp, downsampleSig/max(filtered), 'o')
   xline(t(end)-length(pulse_shape)*samplePeriod)
   ylim([-1.5, 1.5])
   text(t(end)-length(pulse_shape)*samplePeriod, .5, ["The convolution process produces","extra symbols that we ignore"])
   legend(["Output of Match Filter", "Points to Sample"])
   title("Output of Match Filter")
   hold off;
end
end