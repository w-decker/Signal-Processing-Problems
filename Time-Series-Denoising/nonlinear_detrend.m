
%% Nonlinear detrending

% Author: Will Decker
% Code adapted from Mike X. Cohen's "Signal Processing Problems" course

%% Generating polynomials

% parameters
order = 3; % nth order polynomial
x = linspace(-15,15,100); % -15 to 15 in 100 points
y = zeros(size(x));
beta = randn;

% polynomial
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
k = 15; % number of poles for random amplitudes
slowdrift = interp1(100*randn(k,1),linspace(1,k,n),'pchip')';
signal = slowdrift + 20*randn(n,1);

% plot
figure(2),hold on
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
plot(time,yHat,'r','linew',4)
plot(time,residual,'k','linew',2)
legend({'Original';'Polyfit';'Filtered signal'})

%% Using Bayes Information Criterion

% orders
orders = (5:40)';

% sum of squared errors
sse1 = zeros(length(orders),1);

% initiate BIC model
for ri=1:length(orders)
    
    % compute polynomial (fit data to time series)
    yHat = polyval(polyfit(t,signal,orders(ri)),t);
    
    % compute fit of model to data (sum of squared errors)
    sse1(ri) = sum( (yHat-signal).^2 )/n;
end


% Bayes information criterion
BIC = n*log(sse1) + orders*log(n);

% Identify lowest parameter
[bestP,idx] = min(BIC);

% plot
figure(3), clf, hold on
plot(orders,BIC,'ks-','markerfacecolor','w','markersize',8)
plot(orders(idx),bestP,'ro','markersize',10,'markerfacecolor','r')
xlabel('Polynomial order') 
ylabel('Bayes information criterion')
zoom on


%% Use BIC in filter

% polynomial fit
polyfilt = polyfit(time,signal,orders(idx));

% estimated data based on the coefficients
yHat = polyval(polyfilt,time);

% filtered signal is residual
filtsig = signal - yHat;

% plot
figure(4), clf, hold on
h = plot(time,signal);
set(h,'color',[1 1 1]*.6)
plot(time,yHat,'r','linew',2)
plot(time,filtsig,'k')
set(gca,'xlim',time([1 end]))
xlabel('Time (a.u.)')
ylabel('Amplitude')
legend({'Original';'Polynomial fit';'Filtered'})
%%