close all;
% message = "I think dogs should vote!";
% 
% sampleRate = 8/1000;   %Sample rate (samples per second)
% symbolRate = 1/1000;    %Symbol rate (symbols per second)
% samplesPerSymbol = sampleRate/symbolRate;
% 
% pulse_shape = rcosdesign(.2,9,samplesPerSymbol);
% pulse_shape = pulse_shape/max(pulse_shape); %Normalize
% 
% p1 = [zeros(1,samplesPerSymbol) pulse_shape];
% p2 = [pulse_shape zeros(1,samplesPerSymbol)];
% figure;
% hold on;
% plot(p1)
% plot(p2)
% plot(p1.*p2)
% title({'Time-Delayed Pulses'})
% legend('Pulse 1', 'Pulse 2', 'Element-wise product')
% hold off;
% 
% 
% inner = zeros(1,10);
% for i = 1:10
%     p1 = [zeros(1,i) pulse_shape];
%     p2 = [pulse_shape zeros(1,i)];
%     inner(i) = dot(p1,p2);
% end
% figure;
% plot(inner)
% 
% x = [0,0,0,0,0,0,0,.2,.7,1,1,1,1,1,.7,.2,0,0,0,0,0,0,0];
% figure;
% plot(abs(ifft(x)))
% 
% r = encode(message, pulse_shape, sampleRate, symbolRate);
% r = r+rand(size(r))*.5;
% figure;
% plot(r)
% 
% receivedmessage = decode(r, pulse_shape, sampleRate, symbolRate)


 T = 1/50
 beta = .5
 f = linspace(-3/T, 3/T, 1000)

 logical1 = (abs(f)>(1-beta)/(2*T)).*(abs(f)<(1+beta)/(2*T))
 rcos = 1/2*(1+cos(pi*T/beta*(abs(f)-(1-beta)/(2*T))))
 logical2 = (abs(f)<(1-beta)/(2*T))
 rcos=rcos.*logical1
 rcos=rcos+logical2
 figure(3);
 hold on;
 plot(f, rcos)
 plot(f, rcosDelay)
 plot(f, rcosAdvance)
 plot(f, rcos+rcosDelay+rcosAdvance+rcosDelay2+rcosAdvance2, 'LineWidth',3)
 plot(f, rcosDelay2)
 plot(f, rcosAdvance2)

 ylim([-.1, 1.5])
 xlabel("Frequency")
 ylabel("|H(f)|")
 title("A rectangular pulse alongside frequency-shifted copies")
 hold off;
 
 
%  
%  
%  
%  
%  
%  
%  
%  
%  
%  
%  
% 
% 
% 
% Fs = 1000;            % Sampling frequency                    
% beta = .3;
% p = rcosdesign(beta,20,20);
% [P, f] = dualFFT(p,Fs);
% 
% 
% figure;
% hold on;
% title("SRRC Pulse Frequency Domain (\beta = " + beta + ")")
% xlabel("Frequency (Hz)")
% ylabel("Amplitude")
% plot(f(170:235),P(170:235))
% plot(f(170:235),P(170:235))
% hold off;
% % This helper function returns the 2-sided fourier spectrum of a given
% % signal.
% function [P, f] = dualFFT(p, Fs)
%     L = length(p);          % Define signal length
%     P = fftshift(abs(fft(p)/L)); %Calculate pulse FFT, shift to be centered at 0.
%     f = Fs*(0:(L/2))/L;     % Define Frequency range
%     f =[-flip(f), f];       % Paste Frequency range backwards
%     f(length(f)/2) = [];    % Remove duplicate 0
% end