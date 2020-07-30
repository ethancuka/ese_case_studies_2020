%% Circuits testbed script for additional stuff
close all;

%Define transfer functions
circuit1 = tf(1, [R*C 1]);
circuit2 = tf([R*C 0], [R*C 1]);
circuit3 = tf(1, [R_1*C_1 1])*tf([R_2*C_2 0], [R_2*C_2 1]);

% Construct input signal
t = (0:1/Fs:(T-1/Fs));
signal1 = sin(10*2*pi*t);
signal2 = sin(1000*2*pi*t);
signal = signal1+signal2;
signal = audio_timeseries.data;

% Simulate results
c1out = lsim(circuit1, signal, t);
c2out = lsim(circuit2, signal, t);
c3out = lsim(circuit3, signal, t);

% Time series results
figure("Name", "Time Series");
subplot(2,2,1), plot(t,signal), title("Original Signal")
subplot(2,2,2), plot(t,c1out), title("Circuit 1 Output")
subplot(2,2,3), plot(t,c2out), title("Circuit 2 Output")
subplot(2,2,4), plot(t,c3out), title("Circuit 3 Output")

% Calculate PSD
[sigfft, fscale] = psd(signal, Fs);
c1fft = psd(c1out, Fs);
c2fft = psd(c2out, Fs);
c3fft = psd(c3out, Fs);

% Plot PSD
figure("Name", "Frequency Domain");
subplot(3,1,1), hold on, plot(fscale, sigfft), plot(fscale, c1fft), title("Circuit 1 Output"), legend(["Input", "Output"]), set(gca, 'YScale', 'log'), set(gca, 'XScale', 'log'), xlim([10 10^4.3])
subplot(3,1,2), hold on, plot(fscale, sigfft), plot(fscale, c2fft), title("Circuit 2 Output"), set(gca, 'YScale', 'log'), set(gca, 'XScale', 'log'), xlim([10 10^4.3])
subplot(3,1,3), hold on, plot(fscale, sigfft), plot(fscale, c3fft), title("Circuit 3 Output"), set(gca, 'YScale', 'log'), set(gca, 'XScale', 'log'), xlim([10 10^4.3])



% Little helper function to do the FFT stuff
function [output, fscale] = psd(signal, Fs)
nfft = 2^ceil(log2(length(signal))); % next larger power of 2
sigfft = abs(fft(signal,nfft)); % Fast Fourier Transform
%sigfft = abs(sigfft.^2); %Convert to PSD
sigfft = sigfft(1:1+nfft/2); % half-spectrum

output = sigfft;
fscale = (0:nfft/2)* Fs/nfft; % frequency scale
end