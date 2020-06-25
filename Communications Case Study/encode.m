function r = encode(message, pulse_shape, samplePeriod, symbolPeriod)
samplesPerSymbol = symbolPeriod/samplePeriod;

% Convert message to binary
binCode = dec2bin(char(message));
binCode = reshape(binCode',1,numel(binCode));
binCode = logical(binCode(:)'-'0');

% Convert binary to amplitude
modCode = binCode.*2-1;

%Upsample
upsamp = upsample(modCode,samplesPerSymbol);

%Convolve with pulse
r = conv(upsamp, pulse_shape);
end