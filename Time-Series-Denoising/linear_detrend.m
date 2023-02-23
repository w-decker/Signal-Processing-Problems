%% Linear detrending
% Author: Will Decker
% Code adapted from Mike X. Cohen's "Signal Processing Problems" course

%% Generate signal

% parameters

n = 500;
signal = cumsum(randn(1,n)) + linspace(-20, 20, n); % creates signal with noise and linear trend

% filter signal

detrendsig = detrend(signal);

%% Plot

figure(1), clf
plot(1:n, signal, 'r', 1:n, detrendsig, 'b', 'linew', 2)
legend({ [ 'Original signal (mean =' num2str(mean(signal)) ')' ]; ...
    ['Detrended signal (mean =' num2str(mean(detrendsig)) ')'] })
title('Detrending Time Series')

%%