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

%% to do 
% use info.paradigm to pull stim-connected data 
% SSR? - estimate global signal and regress from all
% power spectrum
% phase estimation and visualization
%   phase from fft, stim frequency
%   position from, e.g., center of each NN2
%   maybe: HRF correction? 



%% temp scratch

% Only consider adjacent source-detectors.
dmy = ybp(info.pairs.NN==2 & info.pairs.WL == 2,:);
%Compute and plot Fourier Transform
DMY = fft(dmy,[],2);
fs = info.system.framerate;
f = [0:fs/size(dmy,2):fs-fs/size(dmy,2)];
figure;
    hold on;
        plot(f,abs(DMY), "LineWidth", 1);
        title("Fourier Transform")
        xlabel("Frequency (Hz)")
        ylabel("|H(f)|")
        xlim([0 .25])
    hold off;

% Estimate phase angle of the fourier transform at the stimulus frequency
pEst = angle(DMY(:,13));

% Display histogram of most common phases.
figure;
    hist(pEst,32)

%Generate map of "halfway points" between sources and detectors.
measInd = info.pairs.NN==2 & info.pairs.WL == 2;


mPos = .5*(info.optodes.dpos2(info.pairs.Det(measInd),:)+info.optodes.spos2(info.pairs.Src(measInd),:));

% Generate map of source and detector locations, marking the mean positions
% between them NOTE: not adjacent detectors, only ones with distance 2
figure;
    hold on;
        title("Source-Detector Location Map")
        plot(mPos(:,1),mPos(:,2),'*', "MarkerSize", 7)
        plot(info.optodes.dpos2(info.pairs.Det(measInd),1),info.optodes.dpos2(info.pairs.Det(measInd),2),'ro', "MarkerSize", 3)
        plot(info.optodes.spos2(info.pairs.Src(measInd),1),info.optodes.spos2(info.pairs.Src(measInd),2),'gx', "MarkerSize", 3)
        legend(["Mean Positions", "Detector Positions", "Source Positions"])
        axis image
    hold off;

% Generate colored 3d map of approximate phase of each source-detector
% pair.
figure;
    hold on;
        title("Rotation Phase vs. Optode Position")
        scatter3(mPos(:,1),mPos(:,2),pEst, 36, pEst, 'filled')
        colormap jet
        colorbar
        view(3)
        xlabel("Measurement Position (Horizontal)")
        ylabel("Measurement Position (Vertical)")
        zlabel("Approximate Phase (Rads")
        axis([-60 60 -60 60])
    hold off;

    
%% Test: simple estimation of phase using norm (not robust)
% %Grab a snapshot of the brain at a particular moment. Ideally this should
% %actually be testing data not training data
% slice = data(:,randi([1, size(data,2)]));
% 
% %Find moment in time that most closely corresponds to our snapshot
% minDist = Inf;
% id = 0;
% for i = 1:size(dmy,2)
% dist = norm(slice(info.pairs.NN==2 & info.pairs.WL == 2,:)-dmy(:,i));
% if dist < minDist
%     id = i;
%     minDist = dist;
% end
% end
% % dumb estimate???
% pGuess = mod(id/info.system.framerate*2*pi/36, 2*pi);
