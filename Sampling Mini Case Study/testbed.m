% Test for undersampling stuff
close all;

dT = 20;
newdT = 1000;
B = 10;
T = 2;
t = (0:1/dT:(T-1/dT));

signal = sin(2*pi*9*t) +sin(2*pi*2*t) + sin(2*pi*1*t);
newsig = nyquistUpSamp(signal, dT, newdT);
newt = (0:1/newdT:(T-1/newdT));
perfectsig = sin(2*pi*9*newt) +sin(2*pi*2*newt) + sin(2*pi*1*newt);

figure;
hold on;
plot(t,signal);
plot(newt,newsig);
plot(newt,perfectsig);
legend(["Low sample rate", "Upsampled signal", "Desired signal"]);




t1 = (0:.001:1);
signal1 = sin(2*pi*1*t1)+sin(2*pi*2*t1);

t2 = (0:.25:1);
signal2 = sin(2*pi*1*t2)+sin(2*pi*2*t2);

t3 = (0:1/24:1);
signal3 = nyquistUpSamp(signal2, 4, 24);


freqs = [pi/16, pi/8, pi/4, pi/2, pi, 15*pi/8, 2*pi, 5*pi/2, 3*pi, 4*pi];
t2 = linspace(0,40,1000);
dT = 1
t1 = (0:1/dT:(T-1/dT));
figure;
for f = 1:length(freqs)
    subplot(length(freqs),2,2*f-1)
    stem(n, sin(freqs(f)*n)), title("Discrete, f="+freqs(f)), ylim([-1,1])
    subplot(length(freqs),2,2*f)
    plot(t2, sin(freqs(f)*t2)), title("Continuous, f="+freqs(f)),ylim([-1,1])
end






% figure;
% subplot(1,3,1)
% plot(t1, signal1, 'LineWidth',3), title("Continuous signal"), ylabel("Amplitude"), xlabel("Time (s)")
% subplot(1,3,2)
% plot(t2, signal2, 'LineWidth',3), title("Undersampled signal"), xlabel("Time (s)")
% subplot(1,3,3)
% plot(t3, signal3(1:length(t3)), 'LineWidth',3), title("Interpolated signal"), xlabel("Time (s)"), ylim([-2 2])


%A function for upsampling a signal using the Whittaker-Shannon
%interpolation formula. 
function newsig = nyquistUpSamp(signal, samplerate, newsamplerate)
T = 1/samplerate*(length(signal));
t = (0:1/newsamplerate:(T-1/newsamplerate));
newsig = zeros(size(t));
for n = 1:length(signal)
    newsig = newsig+signal(n)*sinc((t-(n-1)*1/samplerate)*samplerate);
end
end