close all; clear;
%continuous signal
L=1000;
fsim=22000; %sampling frequency of the continuous signal
fc=fsim/L; %fc allows to get 1 cycle of L samples
Tcycle=1/fc; % 1 period
Tcont=1/fsim; %sampling period
continuous_time_axis=[0:Tcont:Tcycle]; %a period of the signal
ycont=sin(2*pi*fc*continuous_time_axis); % a cycle of a continuos sinusoid
%ideal sampled signal
num_samples_cycle=8;
Tm=Tcont*L/num_samples_cycle; %sampling period of the sampled signal
discrete_time_axis=[0:Tm:Tcycle];
ysampled=sin(2*pi*fc*discrete_time_axis);
figure(1);
plot(continuous_time_axis,ycont); title('Cycle of the continuous signal with 8 samples'); xlabel('n');
hold on;
stem(discrete_time_axis,ysampled);
hold off;
%PAM Signal
N=length(ycont); %we take the length of the continuous signal
z=zeros(1,N); % we create an N-length vector of zeros
n=floor(Tm/Tcont); % we divide the period of the discrete signal between the 
                   % period of the continuous signal (we round it). This
                   % will be the increment between the samples of the
                   % sampled signal
z(1:n:N)=ysampled; %we put the values of ysampled in the vector of zeros every n samples;
                    %so we are adding zeros between the samples of the
                    %sampled signal
h=zeros(1,100);
h(1:10)=1; %we create a pulse with a duration of 10 samples
pamreal=conv(h,z); % we convolve the pulse with the sampled signal which contains
                   % the zeros between each sample
figure()
plot(pamreal(1:L));title('PAM Signal'); xlabel('n')
figure(); %we are going to plot the continuous signal and the PAM signal overlapped
plot(continuous_time_axis, pamreal(1:N));title('PAM signal and continuous signal overlapped'); xlabel('n')
hold on;
plot(continuous_time_axis, ycont)
%FREQUENCY DOMAIN
freq_axis=[-fsim/2:fc:fsim/2];
YCONT=fft(ycont); %spectrum of the continuous signal
figure()
subplot(3,1,1)
stem(freq_axis, fftshift(abs(YCONT)));title('Spectrum of the continuous sinusoide');xlabel('f')
freq_axis2=[-fsim/2:fsim/8:fsim/2];
YSAMPLED=fft(ysampled); %spectrum of the discrete signal which represents 8
                        %8 samples of the continous signal
subplot(3,1,2)
stem(freq_axis2,fftshift(abs(YSAMPLED)));title('Spectrum of the discrete sinusoide');xlabel('f')
subplot(3,1,3)
stem((-50:49),fftshift(abs(fft(h))));title('Spectrum of the rectangular pulse');xlabel('f')
figure()
stem((-L/2: L/2-1),fftshift(abs(fft(pamreal(1:L)))));title('Spectrum of the PAM signal'); xlabel('f')
figure()
stem(freq_axis, fftshift(abs(YCONT)));title('Spectrum of the continuous sinusoide and the PAM signal');xlabel('f')
hold on;
stem(freq_axis, fftshift(abs(fft(pamreal(1:N)))))