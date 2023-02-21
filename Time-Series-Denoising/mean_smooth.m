%% Time Series Denoising
% Author: Will Decker
% Code adapted from Mike X. Cohen's "Signal Processing Problems" course

%% Section 1: Mean-smooth time series

% signal parameters

samplerate = 1000; % measured in Hz
time = 0:1/samplerate:3; % 1 sample point over 3 seconds
n = length(time);
p = 15; % time points

% generate noise

noiselevel = 3; % measured in standard deviations
noise = noiselevel * randn(size(time)); % randomly generate noise along signal

% amplitude modulator

ampl = interp1(randn(p,1)*25, linspace(1,p,n));

% generate signal

signal = ampl + noise;

figure(1), clf, hold on
subplot(221)
plot(time, ampl, 'Color', [0.6, 0 ,0]), title('raw signal without noise')
subplot(222)
plot(signal) , title('raw signal with added noise')

% show signals superimposed on eachother 

figure(2), clf, hold on
plot(time, signal, time, ampl, 'linew', 2)
zoom on

% filtered signal vector

filtsig = ones(size(signal)); % or filtsig = signal

% implement the mean-smooth in the *time* domain

k = 100; % filter window

for i = k + 1:n - k - 1

    filtsig(i) = mean(signal(i - k:i + k)); % each point along the filtered signal is the average of 'k' surrounding points

end

% convert windosize to ms

windowsize = 1000 * (k*2 + 1) / samplerate;

% plot noisy and filtered signal

figure(3), clf, hold on
plot(time, signal, time, filtsig, 'linew', 2)
timeindex = dsearchn(time', 1);
ylim = get(gca, 'ylim');
patch(time([ timeindex-k timeindex-k timeindex+k timeindex+k ]),ylim([ 1 2 2 1 ]),'k','facealpha',.25,'linestyle','none')
plot(time([timeindex timeindex]),ylim,'k--')
xlabel('Time (sec.)'), ylabel('Amplitude')
title([ 'Running-mean filter with a k=' num2str(round(windowsize)) '-ms filter' ])
legend({'Signal';'Filtered';'Window';'window center'})

zoom on 


%%