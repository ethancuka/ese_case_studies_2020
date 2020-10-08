
close all;


%% Sampling and undersampling

freqs = [pi/16, pi/8, pi/4, pi/2, pi, 15*pi/8, 2*pi, 5*pi/2, 3*pi, 4*pi];
t2 = linspace(0,40,1000);
dT = 1
t1 = (0:1/dT:(T-1/dT));
figure;
for w = 1:length(freqs)
    subplot(length(freqs),2,2*w)
    stem(t1, sin(freqs(w)*t1)), title("Discrete, \omega="+freqs(w)), ylim([-1,1])
    subplot(length(freqs),2,2*w-1)
    plot(t2, sin(freqs(w)*t2)), title("Continuous, \omega="+freqs(w)),ylim([-1,1])
end



%% Interpolation
% The lowsample variable in the workspace is a timeseries representing a
% signal sampled at its Nyquist Rate of 20 Hz. The highsample variable is
% the same signal sampled at 200 Hz. Your goal for this case study is to
% interpolate the signal with the lower sample rate using the
% Whittaker-Shannon interpolation formula provided in the case study
% document. You can compare your work to the highsample signal to see how
% you did.