%% Circuits Case Study Script
% This script is for use with the Circuits Case Study simulink model. The
% model must be run first or this script will not work.

close all; 
% Retrieve simulation data
t =  simdata.output.time;
output = simdata.output.data;
input = simdata.input.data;

% Remove any DC offset
output = output - mean(output); 
input = input - mean(input);

% Plot input and output in time domain
figure("Name","Time Series")
subplot(2,1,1), plot(t,output),  axis('tight'), grid('on'), title('Output')
subplot(2,1,2), plot(t,input),  axis('tight'), grid('on'), title('Input')

% Compute Power Spectral Density of input and output

nfft = 2^ceil(log2(length(output))); % next larger power of 2
yout = fft(output,nfft); % Fast Fourier Transform
yout = abs(yout.^2); % raw power spectrum density
yout = yout(1:1+nfft/2); % half-spectrum

yin = fft(input,nfft); % Fast Fourier Transform
yin = abs(yin.^2); % raw power spectrum density
yin = yin(1:1+nfft/2); % half-spectrum

f_scale = (0:nfft/2)* Fs/nfft; % frequency scale

% Plot Power Spectral Density
figure("Name", "Power Spectral Density")
hold on;
plot(f_scale, yin),axis('tight'),grid('on'),title('Power Spectral Densities'),xlabel("Frequency (Rads/s)"), ylabel("Power (W)")
plot(f_scale, yout), legend(["Circuit 3 Input", "Circuit 3 Output"]), ylim([.1 max([yin' yout'])])
xlim([10 10^4.3]), set(gca, 'YScale', 'log'), set(gca, 'XScale', 'log'), set(gcf, 'Position',  [25, 50, 1000, 400])
xline(1/(2*pi*R_1*C_1),'HandleVisibility','off'), text(1/(2*pi*R_1*C_1), 10, "\leftarrow Cut-off 1")
xline(1/(2*pi*R_2*C_2),'HandleVisibility','off'), text(1/(2*pi*R_2*C_2), 10, "\leftarrow Cut-off 2")
hold off;


% Play sound before and after
disp("Playing input sound...")
sound(simdata.input.data, Fs)
pause(T+1)
disp("Playing output sound...")
sound(simdata.output.data, Fs)
pause(T+1)
disp("Done!")