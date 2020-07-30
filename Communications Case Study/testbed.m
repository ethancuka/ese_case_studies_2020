close all;
% message = "Dog";
%
w = 100
t = 0:.001:(2*3*pi/100);
x = sin(100*t)
y = sin(100*(t-pi/4))/(10*sqrt(2))
figure;
title("Input and Output of a Simple Transfer Function")
hold on;
plot(t,x)
plot(t,y)
legend(["Input", "Output"])
% Tsamp = 1/4000;            % Sample period - the time between each sample.
% Tsymb = 8/1000;            % Symbol period - the time between each symbol
% symbolLength = Tsymb/Tsamp;% The duration, in samples, of each symbol
% 
% truncate = 7;              % Your pulse will probably be longer than a 
%                            % single symbol period. This determines how many
%                            % symbols into the past and future to cut it 
%                            % off.
%                            
% t = (-truncate*Tsymb:Tsamp:truncate*Tsymb); %Generate time vector
% 
% 
% % For simplicity, we will use a truncated sinc function as our pulse shape.
% % An Rcos pulse would work better, but most students will likely use a sinc
% % function.
% time_pulse = sinc(t/Tsymb); %Your function here.
% figure;
% hold on;
% plot(t*1000, time_pulse, 'LineWidth', 3)
% title("Pulse Shape")
% ylabel("Amplitude")
% xlabel("Time (ms)")
% grid on;
% 
% symbols = [0, 7, -1, -3, -3, 3, 7, 3];
% upsamp = upsample(symbols, symbolLength)
% tupsamp = 0:Tsamp:(Tsymb*length(symbols))-Tsamp
% 
% figure;
% hold on;
% title("Symbol Sequence times Pulse Shape")
% for i = 1:length(symbols)
%     plot((t+i*Tsymb)*1000, time_pulse*symbols(i))
% end
% plot((tupsamp+Tsymb)*1000, upsamp, "LineWidth", 3)
% ylabel("Amplitude")
% xlabel("Time (ms)")
% xlim([0, Tsymb*1000*(length(symbols)+1)])
% figure;
% hold on;
% title("Transmitted Signal")
% con = conv(upsamp, time_pulse)
% tcon = 0:Tsamp:(Tsamp*length(con))-Tsamp
% plot(tcon*1000,con, 'LineWidth', 3)
% ylabel("Amplitude")
% xlabel("Time (ms)")
% figure;
% hold on;
% title("Symbol Sequence")
% xlabel("Time (ms)")
% ylabel("Symbol Amplitude")
% plot(tupsamp*1000, upsamp, 'LineWidth', 3)
% ylim([-4, 8])
% ax = gca;
% ax.XGrid = 'off';
% ax.YGrid = 'on';
% set(gca,'ytick',-4:1:8)
% 
% 
% figure;
% con = conv(con, time_pulse)
% tcon = 0:Tsamp:(Tsamp*length(con))-Tsamp
% 
% figure;
% hold on;
% title("Matched Filter Output")
% plot((tcon-2*truncate*Tsymb)*1000,7*con/(max(con)), 'LineWidth', 3)
% plot(tupsamp*1000, upsamp, 'LineWidth', 3)
% legend(["Matched Filter Output", "Original Symbol Sequence"], 'location', 'Best')
% ylabel("Amplitude")
% xlabel("Time (ms)")
% xlim([0, 60])
% 
% normcon = 7*con/max(con);
% downsampleSig = normcon(34+2*truncate*symbolLength:symbolLength:end);
% downsampleSig = downsampleSig(1:length(symbols)-1)
% figure;
% hold on;
% title("Received Symbol Sequence")
% stem(downsampleSig, 'LineWidth', 3, 'MarkerSize',10)
% xlim([0, 8])
% ax = gca;
% ax.XGrid = 'off';
% ax.YGrid = 'on';
% set(gca,'ytick',-4:1:8)
% 
% % Tsamp = 1/100;            % Sample period - the time between each sample.
% % Tsymb = ;            % Symbol period - the time between each symbol
% % symbolLength = Tsymb/Tsamp;% The duration, in samples, of each symbol
% % 
% % truncate = 7;              % Your pulse will probably be longer than a 
% %                            % single symbol period. This determines how many
% %                            % symbols into the past and future to cut it 
% %                            % off.
% %                            
% % t = (-truncate*Tsymb:Tsamp:truncate*Tsymb); %Generate time vector
% % delay = Tsymb*2
% % time_pulse = sinc(t/Tsymb);
% % time_pulse2 = sinc((t-delay)/Tsymb);
% % product = conv(time_pulse, time_pulse, 'same')
% % figure();
% % subplot(1,2,1)
% % hold on;
% % title("Original Signal")
% % plot(t,time_pulse, 'LineWidth', 1.5)
% % xL = xlim;
% % yL = ylim;
% % line(xL, [0 0], 'Color', [0.7 0.7 0.7]);
% % subplot(1,2,2)
% % hold on;
% % title("Autocorrelation")
% % plot(t,product, 'LineWidth', 1.5)
% % xL = xlim;
% % line(xL, [0 0], 'Color', [0.7 0.7 0.7]);
% % set(gcf, 'Position',  [100, 100, 1000, 400])
% % 
% 
% % close all;
% % % message = "I think dogs should vote!";
% % % 
% % % sampleRate = 8/1000;   %Sample rate (samples per second)
% % % symbolRate = 1/1000;    %Symbol rate (symbols per second)
% % % samplesPerSymbol = sampleRate/symbolRate;
% % % 
% % % pulse_shape = rcosdesign(.2,9,samplesPerSymbol);
% % % pulse_shape = pulse_shape/max(pulse_shape); %Normalize
% % % 
% % % p1 = [zeros(1,samplesPerSymbol) pulse_shape];
% % % p2 = [pulse_shape zeros(1,samplesPerSymbol)];
% % % figure;
% % % hold on;
% % % plot(p1)
% % % plot(p2)
% % % plot(p1.*p2)
% % % title({'Time-Delayed Pulses'})
% % % legend('Pulse 1', 'Pulse 2', 'Element-wise product')
% % % hold off;
% % % 
% % % 
% % % inner = zeros(1,10);
% % % for i = 1:10
% % %     p1 = [zeros(1,i) pulse_shape];
% % %     p2 = [pulse_shape zeros(1,i)];
% % %     inner(i) = dot(p1,p2);
% % % end
% % % figure;
% % % plot(inner)
% % % 
% % % x = [0,0,0,0,0,0,0,.2,.7,1,1,1,1,1,.7,.2,0,0,0,0,0,0,0];
% % % figure;
% % % plot(abs(ifft(x)))
% % % 
% % % r = encode(message, pulse_shape, sampleRate, symbolRate);
% % % r = r+rand(size(r))*.5;
% % % figure;
% % % plot(r)
% % % 
% % % receivedmessage = decode(r, pulse_shape, sampleRate, symbolRate)
% % 
% % 
% %  T = 1/50
% %  beta = .5
% %  f = linspace(-3/T, 3/T, 1000)
% % 
% %  logical1 = (abs(f)>(1-beta)/(2*T)).*(abs(f)<(1+beta)/(2*T))
% %  rcos = 1/2*(1+cos(pi*T/beta*(abs(f)-(1-beta)/(2*T))))
% %  logical2 = (abs(f)<(1-beta)/(2*T))
% %  rcos=rcos.*logical1
% %  rcos=rcos+logical2
% %  figure(3);
% %  hold on;
% %  plot(f, rcos)
% %  plot(f, rcosDelay)
% %  plot(f, rcosAdvance)
% %  plot(f, rcos+rcosDelay+rcosAdvance+rcosDelay2+rcosAdvance2, 'LineWidth',3)
% %  plot(f, rcosDelay2)
% %  plot(f, rcosAdvance2)
% % 
% %  ylim([-.1, 1.5])
% %  xlabel("Frequency")
% %  ylabel("|H(f)|")
% %  title("A rectangular pulse alongside frequency-shifted copies")
% %  hold off;
% %  
% %  
% % %  
% % %  
% % %  
% % %  
% % %  
% % %  
% % %  
% % %  
% % %  
% % %  
% % %  
% % % 
% % % 
% % % 
% % % Fs = 1000;            % Sampling frequency                    
% % % beta = .3;
% % % p = rcosdesign(beta,20,20);
% % % [P, f] = dualFFT(p,Fs);
% % % 
% % % 
% % % figure;
% % % hold on;
% % % title("SRRC Pulse Frequency Domain (\beta = " + beta + ")")
% % % xlabel("Frequency (Hz)")
% % % ylabel("Amplitude")
% % % plot(f(170:235),P(170:235))
% % % plot(f(170:235),P(170:235))
% % % hold off;
% % % % This helper function returns the 2-sided fourier spectrum of a given
% % % % signal.
% % % function [P, f] = dualFFT(p, Fs)
% % %     L = length(p);          % Define signal length
% % %     P = fftshift(abs(fft(p)/L)); %Calculate pulse FFT, shift to be centered at 0.
% % %     f = Fs*(0:(L/2))/L;     % Define Frequency range
% % %     f =[-flip(f), f];       % Paste Frequency range backwards
% % %     f(length(f)/2) = [];    % Remove duplicate 0
% % % end
