% Curious how the encode and decode functions for this lab work? The answer
% is suprisingly simple. Here's the function that turns your message into a
% signal to be transmitted.

function r = encode(message, pulse_shape, samplePeriod, symbolPeriod, figurePlotting)
% Our encoder has to know how much time should pass between sending each
% pulse. Since it works in discrete time using samples instead of seconds,
% this line tell it how many samples to wait before sending the next pulse.
samplesPerSymbol = symbolPeriod/samplePeriod;

% Here we convert the given message from ASCII code into binary
binCode = dec2bin(char(message));
binCode = reshape(binCode',1,numel(binCode));
binCode = logical(binCode(:)'-'0');

% A fancier transmitter would use a look-up table or some other method to
% map bits to amplitude, but since we only have 2 symbols, we can use this
% little trick to quickly map 1 to +1 and 0 to -1, converting our bit
% sequence into amplitudes.
modCode = binCode.*2-1;

% "Upsampling" the symbol map means placing zeroes in between the
% entries. The number of zeros we add is based on our symbol period.
upsamp = upsample(modCode,samplesPerSymbol);

%We can think of our pulse shape as an impulse response and our upsampled
%symbol stream as the input. Every symbol period, we hit our impulse
%response with a pulse that is either positive or negative, depending on
%whether we want to send a 1 or a 0. The convolution of all of these
%impulse responses is the resulting signal we transmit.
r =  conv(upsamp, pulse_shape);


% This bit down here just plots figures,
if figurePlotting
   t = 0:samplePeriod:(length(upsamp)-1)*samplePeriod;
   figure;
   hold on;
   plot(t*1000,upsamp)
   title("Upsampled Symbol Sequence")
   xlabel("Time (ms)")
   ylim([-1.5,1.5])
   hold off;
   
   t = 0:samplePeriod:(length(r)-1)*samplePeriod;
   figure;
   hold on;
   plot(t*1000, r)
   title("Transmitted Signal")
   xlabel("Time (ms)")
   hold off;
end
end