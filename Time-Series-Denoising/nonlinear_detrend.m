%% Non-linear detrending
% Author: Will Decker
% Code adapted from Mike X. Cohen's "Signal Processing Problems" course

%% Generating polynomials

% parameters

order = 0; % nth order polynomial
x = linspace(-15,15,100); % -15 to 15 in 100 points
y = zeros(size(x));
beta = randn;

for i=1:order+1
    y = y + beta*x.^(i-1); % y, original signal
end

% plot

figure(1), clf, hold on
plot(x,y,'linew',4)
title([ 'Order-' num2str(order) ' polynomial' ])

%% Generate signal with polynomial artifact

n = 10000;
time = (1:n)';
k = 10; % number of poles for random amplitudes
slowdrift = interp1(100*randn(k,1),linspace(1,k,n),'pchip')';
signal = slowdrift + 20*randn(n,1);

% plot

figure(2), clf, hold on
H = plot(time,signal);
set(H,'color',[1 1 1]*.6)
xlabel('Time (a.u.)')
ylabel('Amplitude')

%% Identifying polynomials in signal

% polynomial fit

p = polyfit(time,signal,3); % fits nth order polynomial (3rd parameter) into time and signal
disp(p)

% predicted data is evaluation of polynomial

yHat = polyval(p,time); 

% compute residual (the cleaned signal)

residual = signal - yHat;

% plot

figure(2) % rerun fig2 in previous chunk if needed
plot(t,yHat,'r','linew',4)
plot(t,residual,'k','linew',2)
legend({'Original';'Polyfit';'Filtered signal'})

