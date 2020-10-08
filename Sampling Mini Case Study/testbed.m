% % Test for undersampling stuff
% close all;
% 
% dT = 20;
% newdT = 10000;
% B = 10;
% T = 2;
% t = (0:1/dT:(T-1/dT));
% 
% signal = sin(2*pi*9*t) +sin(2*pi*2*t) + sin(2*pi*1*t);
% newsig = nyquistUpSamp(signal, dT, newdT);
% newt = (0:1/newdT:(T-1/newdT));
% perfectsig = sin(2*pi*9*newt) +sin(2*pi*2*newt) + sin(2*pi*1*newt);
% 
% figure;
% hold on;
% plot(t,signal);
% plot(newt,newsig);
% plot(newt,perfectsig);
% legend(["Discrete", "Interpolated", "Continuous"]);
% 

close all;
X = linspace(-1, 3, 74);
Y = 1-X.^2/3;
Z = ((X-3).^2+(Y-3).^2).*(4*X.^2+9*Y.^2<=36).*(X>-1);

x1 = -1*ones(size(Y));
y1 = -sqrt((36-4*X.^2)/9);
figure;
[minval, minind] = min(Z(Z>0));
[maxval, maxind] = max(Z);

%surf(X,Y,Z)

plot3(X,Y,Z)
hold on;
stem3(X,Y,Z, 'Marker', 'none')
plot(X,Y)
plot(x1,Y)
plot(X,y1)
plot3(X(minind), Y(minind), Z(minind), 'o')
plot3(X(maxind), Y(maxind), Z(maxind), 'o')
text(X(minind), Y(minind), Z(minind),"Minimum")
text(X(maxind), Y(maxind), Z(maxind),"Maximum")
xlim([-2,3])
ylim([-2,2])




% 
% 
% 
% t1 = (0:.001:1);
% signal1 = sin(2*pi*1*t1)+sin(2*pi*2*t1);
% 
% t2 = (0:.25:1);
% signal2 = sin(2*pi*1*t2)+sin(2*pi*2*t2);
% 
% t3 = (0:1/24:1);
% signal3 = nyquistUpSamp(signal2, 4, 24);
% 
% dT = 2;
% n = 1:10*dT;
% signal = double(n>=2*dT); %Input voltage
% out2 = zeros(size(n));
% for i = 1:length(out2)-1
%    out2(i+1) = (1-1/(dT))*out2(i)+signal(i)/(dT);
% end
% 
% figure;
% hold on;
% plot(t,out1)
% plot(t,double(t>=2))
% stem(n/dT,out2)
% 
% 
% 
% 
% 
% 
% % figure;
% % subplot(1,3,1)
% % plot(t1, signal1, 'LineWidth',3), title("Continuous signal"), ylabel("Amplitude"), xlabel("Time (s)")
% % subplot(1,3,2)
% % plot(t2, signal2, 'LineWidth',3), title("Undersampled signal"), xlabel("Time (s)")
% % subplot(1,3,3)
% % plot(t3, signal3(1:length(t3)), 'LineWidth',3), title("Interpolated signal"), xlabel("Time (s)"), ylim([-2 2])
% 
% 
% %A function for upsampling a signal using the Whittaker-Shannon
% %interpolation formula. 
% function newsig = nyquistUpSamp(signal, samplerate, newsamplerate)
% T = 1/samplerate*(length(signal));
% t = (0:1/newsamplerate:(T-1/newsamplerate));
% newsig = zeros(size(t));
% for n = 1:length(signal)
%     newsig = newsig+signal(n)*sinc((t-(n-1)*1/samplerate)*samplerate);
% end
% end