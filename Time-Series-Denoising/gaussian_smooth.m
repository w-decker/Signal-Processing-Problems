%% Gaussian-smooth filter of time series data
% Author: Will Decker
% Code adapted from Mike X. Cohen's "Signal Processing Problems" course

%%

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

% signal

signal = ampl + noise;

%% Generate Gaussian kernel

% full width at half maximum, 'w', (FWHM)

w = 40;

% normalized time vector

k = 50; % filter window
t = 1000 * (-k:k)/samplerate;

% create Gaussian formula

gaussian = exp(-(4*log(2)*t.^2)/w^2);

% create emperical 'w', emperical FWHM

prePeakHalf = k + dsearchn(gaussian(k + 1:end)', .5); % 50 percent gain
postPeakHalf = dsearchn(gaussian(1:k)', .5); % 50 percent gain
empericalw = t(prePeakHalf) - t(postPeakHalf);

%% Plot Gaussian

% figure

figure(1), clf, hold on 
plot(t, gaussian, 'ko-', 'MarkerFaceColor', 'g', 'linew', 2)
plot(t([prePeakHalf postPeakHalf]), gaussian([prePeakHalf postPeakHalf]), 'm', 'linew', 3);

% normalize Gaussian to unit energy (keeps the filtered signal to scale of raw signal

gaussian = gaussian / sum(gaussian); % total probability density = 1, area under the curve = 1, allows filtered signal to be in same units as original signal
title([ 'Gaussian kernel with requeted FWHM ' num2str(w) ' ms (' num2str(empericalw) ' ms achieved)' ])
xlabel('Time (ms)'), ylabel('Gain')

%% Implement filter

% filter signal vector

filtsig = zeros(size(signal));

% implement gaussian filter

for i = k + 1:n - k - 1

    filtsig(i) = sum(signal(i - k: i +k).*gaussian);

end


%% Plot filtered signal

% figure

figure(2), clf, hold on
plot(time, signal, 'r');
plot(time, filtsig, 'k', 'linew', 2);
xlabel('Time (s)'), ylabel('amp. (a.u.)')
legend({'Original signal';'Gaussian-filtered'})
title('Gaussian smoothing filter')

zoom on

%% 