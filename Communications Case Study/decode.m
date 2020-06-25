function message = decode(r, pulse_shape, sampleRate, symbolRate)
samplesPerSymbol = symbolRate/sampleRate;

%Apply matched filter in reverse
filtered = flip(filter(pulse_shape,1,flip(r)));

%Downsample
downsampleSig = filtered(1:samplesPerSymbol:end);

% Retrieve binary sequence
decision = downsampleSig>0;

% Shave off extra entries from convolving
trim = 7*floor(length(decision)/7);
message = binvector2str(decision(1:trim));
end