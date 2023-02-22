%% TKEO of EMG data
% Author: Will Decker
% Code adapted from Mike X. Cohen's "Signal Processing Problems" course

%% Visualizing raw signal

% load EMG data

load emg4TKEO.mat

% plot raw EMG data

figure(1), clf
plot(emgtime, emg)

%% Imploy TKEO

% initialize filtered signal

emgfilt1 = emg;
emgfilt2 = emg;

% TKEO formula using loop

for i = 2:length(emgfilt1) - 1

    emgfilt1(i) = emg(i)^2 - (emg(i-1)*emg(i+1));

end

% TKEO forumla using vector

emgfilt2(2:end - 1) = emg(2:end -1).^2 - emg(1:end - 2).*emg(3:end);

%% Convert signal to zscore

% identify timepoint '0'

timepoint0 = dsearchn(emgtime', 0); % signal before 0 is baseline

% convert raw signal to zscore

emgZ = (emg - mean(emg(1:timepoint0))) / std(emg(1:timepoint0));

% convert filtered signal to zscore

emgfiltZ = (emgfilt1 - mean(emgfilt1(1:timepoint0))) / std(emgfilt1(1:timepoint0));

%% plot 

figure(2), clf
subplot(211), hold on % raw, noramlized to max - 1
plot(emgtime,emg./max(emg),'b','linew',2)
plot(emgtime,emgfilt1./max(emgfilt1),'m','linew',1)

% labels

xlabel('Time (ms)')
ylabel('Amplitude or energy')
legend({'EMG';'EMG energy (TKEO)'})
title('Normalized to max, NOT zscore corrected')

subplot(212), hold on % zscored filter
plot(emgtime, emgZ, 'b', 'LineWidth', 2)
plot(emgtime, emgfiltZ, 'm', 'LineWidth',1)

% labels

xlabel('Time (ms)')
ylabel('Zscore relative to pre-stimulus')
legend({'EMG';'EMG energy (TKEO)'})
title('zscore corrected')





