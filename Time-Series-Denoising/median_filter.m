%% Gaussian-smooth filter of time series data
% Author: Will Decker
% Code adapted from Mike X. Cohen's "Signal Processing Problems" course

%% generating signal with brownian noise/integrated white noise

% parameters

n = 5000;
signal = cumsum(randn(n,1));

% proportion of signal to replace with outliers

noise = 0.001;

% find outliers

noisepoints = randperm(n); % random order of n points
noisepoints = noisepoints(1:round(n*noise));

% generate signal and replace points with noise

signal(noisepoints) = 50+rand(size(noisepoints))*100;

% plot

plot(signal, 's-')

%% Visually inspect data

figure(1), clf
histogram(signal, 100)

%% Identify thresholds

threshold = iqr(signal);

% identify datapoints greater than threshold

suprathreshold = find(signal > threshold);

%% Filter signal

% filter signal 

filtsig = signal;

% loop through suprathreshold points and set to median of k

k = median(signal); % actual window is k*2+1
for i=1:length(suprathreshold)
    
    % find lower and upper bounds 
    lower = max(1,round(suprathreshold(i)-k)); % lower boundary, if first timepoint does not fit index, choose 1
    upper = min(round(suprathreshold(i)+k),n); % upper boundary, if last timepoint does not fit index, choose the last timepoint

    % compute median of surrounding points
    filtsig(suprathreshold(i)) = median(signal(lower:upper));
end

%% Plot 

figure(1), clf, hold on
plot(1:n, signal, 'b','linew', 2)
plot(1:n, filtsig, 'r' , 'linew', 1)
title('using median filter')

%%