%%
close all;
load('NeuroDOT_Data_Sample_CCW1.mat'); % data, info, flags

%% grid 
figure, PlotSD(info.optodes.spos3,info.optodes.dpos3)
title("Sensor Layout Diagram")

%% data traces
figure, semilogy(data(info.pairs.r3d < 30,:)')
title("Data Traces")
%% LFO 
figure, semilogy(info.pairs.r3d,mean(data,2),'.')
title("LFO")
xlabel("Penetration Distance")
ylabel("Mean Signal Intensity")

%% log-ratio differential data
y = -log(bsxfun(@times,data,1./mean(data,2)));

%% log-ratio signals
% This plot 
maxDistance = 40;

figure, imagesc(y(info.pairs.r3d<maxDistance,:)), caxis([-.2 .2])
title("Log-Ratio Signals")
xlabel("Time")
%% bandpass result
% Students version won't have this graph made for them, they'll have to
% make it themselves
ybp = lowpass(highpass(y,.02,10),.2,10);
figure, imagesc(ybp(info.pairs.r3d<40,:)), caxis([-.05 .05])

%% just WL 2, NN2
figure
% imagesc(ybp(info.pairs.r3d<40 & info.pairs.WL == 2,:)), caxis([-.02 .02]), colorbar
% imagesc(ybp(info.pairs.NN==1 & info.pairs.WL == 2,:)), caxis([-.02 .02]), colorbar
% imagesc(ybp(info.pairs.NN==3 & info.pairs.WL == 2,:)), caxis([-.02 .02]), colorbar
imagesc(ybp(info.pairs.NN==2 & info.pairs.WL == 2,:)), caxis([-.02 .02]), colorbar

dmy = ybp(info.pairs.NN==2 & info.pairs.WL == 2,:);
DMY = fft(dmy')';


fs = info.system.framerate;
f = [0:fs/size(DMY,2):fs-fs/size(DMY,2)];
figure
plot(f,angle(DMY))
figure
hold on;
subplot(2,1,1)
plot(f,abs(DMY(13,:)))
subplot(2,1,2)
plot(f,angle(DMY(13,:)))


measID = info.pairs.NN==2 & info.pairs.WL == 2;
mPos = .5*(info.optodes.dpos2(info.pairs.Det(measID),:)+info.optodes.spos2(info.pairs.Src(measID),:));

figure
plot(mPos(:,1), mPos(:,2),'o')
axis('image')
%% to do 
% use info.paradigm to pull stim-connected data 
% SSR? - estimate global signal and regress from all
% power spectrum
% phase estimation and visualization
%   phase from fft, stim frequency
%   position from, e.g., center of each NN2
%   maybe: HRF correction? 

