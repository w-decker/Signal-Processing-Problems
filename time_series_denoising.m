%% Time Series Denoising
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

figure(1), clf
signal = ampl + noise;
subplot(221)
plot(time, ampl), title('signal without noise')
subplot(222)
plot(signal) , title('signal with added noise')

