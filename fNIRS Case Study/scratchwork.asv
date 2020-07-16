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
maxDistance = 40

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

%% to do 
% use info.paradigm to pull stim-connected data 
% SSR? - estimate global signal and regress from all
% power spectrum
% phase estimation and visualization
%   phase from fft, stim frequency
%   position from, e.g., center of each NN2
%   maybe: HRF correction? 



%% temp scratch

dmy = ybp(info.pairs.NN==2 & info.pairs.WL == 2,:);
DMY = fft(dmy,[],2);
fs = info.system.framerate;
f = [0:fs/size(dmy,2):fs-fs/size(dmy,2)];
figure, plot(f,abs(DMY'))
figure, plot(dmy(40,:))
figure, plot(f,abs(DMY(40,:)))
pEst = angle(DMY(:,13));
hist(pEst)
hist(pEst,32)
measInd = info.pairs.NN==2 & info.pairs.WL == 2;

mPos = .5*(info.optodes.dpos2(info.pairs.Det(measInd),:)+info.optodes.spos2(info.pairs.Src(measInd),:));
figure
plot(mPos(:,1),mPos(:,2),'*')
axis image
hold on
plot(info.optodes.dpos2(info.pairs.Det(measInd),1),info.optodes.dpos2(info.pairs.Det(measInd),2),'ro')
plot(info.optodes.dpos2(info.pairs.Src(measInd),1),info.optodes.dpos2(info.pairs.Src(measInd),2),'gx')
plot(info.optodes.spos2(info.pairs.Src(measInd),1),info.optodes.spos2(info.pairs.Src(measInd),2),'gx')

plot3(mPos(:,1),mPos(:,2),pEst,'*')
axis image
help plot3
help plot
colormap winter
cMap = hot(128);

figure, plot3(mPos(:,1),mPos(:,2),pEst,cMap(max(round(127*(pEst+pi)/(2*pi))+1)))
cMap(max(round(127*(pEst+pi)/(2*pi))+1),:)
cMap((round(127*(pEst+pi)/(2*pi))+1),:)
figure, plot3(mPos(:,1),mPos(:,2),pEst,cMap((round(127*(pEst+pi)/(2*pi))+1),:))
size(cMap((round(127*(pEst+pi)/(2*pi))+1),:))
figure
for i = 1:128
plot3(mPos(i,1),mPos(i,2),pEst(i),cMap((round(127*(pEst(i)+pi)/(2*pi))+1),:)), hold on
end
cMap((round(127*(pEst(i)+pi)/(2*pi))+1),:)
plot3(mPos(i,1),mPos(i,2),pEst(i),'r*'), hold on
plot3(mPos(i,1),mPos(i,2),pEst(i),cMap((round(127*(pEst(i)+pi)/(2*pi))+1),:)), hold on
plot(mPos(i,1),mPos(i,2),cMap((round(127*(pEst(i)+pi)/(2*pi))+1),:)), hold on
mPos(i,1)
mPos(i,2)
cMap((round(127*(pEst(i)+pi)/(2*pi))+1),:)
plot(1,2,[0 .5 0])
help plot
plot(1,2,[0 .5 0])
plot(1,2,'Color',[0 .5 0])
for i = 1:128
plot(mPos(i,1),mPos(i,2),'Color',cMap((round(127*(pEst(i)+pi)/(2*pi))+1),:)), hold on
end
figure
hold on
for i = 1:128
plot(mPos(i,1),mPos(i,2),'Color',cMap((round(127*(pEst(i)+pi)/(2*pi))+1),:)), hold on
end
axis image
fNIRSCaseStudySample