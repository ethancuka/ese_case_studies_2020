%%
load('NeuroDOT_Data_Sample_CCW1.mat'); % data, info, flags

%% grid 
figure, PlotSD(info.optodes.spos3,info.optodes.dpos3)

%% data traces
figure, semilogy(data(info.pairs.r3d < 30,:)')

%% LFO 
figure, semilogy(info.pairs.r3d,mean(data,2),'.')

%% log-ratio differential data
y = -log(bsxfun(@times,data,1./mean(data,2)));

%% log-ratio signals
figure, imagesc(y(info.pairs.r3d<40,:)), caxis([-.2 .2])

%% bandpass result

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

