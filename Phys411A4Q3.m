%% Assignment 4 Question 3
%%
clc; % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
LW = 1;
FS = 18;

%% Part a) Time series plot
%number of data points
NN = 3*10^4;
TL = 30;
time = linspace(-15, 15, NN);
%Time series
x1_t = cos(22*pi*time);
xx_t = x1_t + 0.7*sin(14*pi*time) + 0.5*sin(147*pi*time);

figure(1), clf, land;
plot(time, xx_t, 'linewidth', LW);
xlabel('Time [s]');
ylabel('x(t)');
axis([-1 1 -3 3]);
title('Time series plot');
fontchan(FS)

%% Part b) PSD of x(t)
%power of 2
NFFT = 2^(nextpow2(length(xx_t))-1);
%frames sampled
fsamp = NN/TL;
[pow, freq] = pwelch(xx_t, NFFT, NFFT/2, NFFT, fsamp, 'onesided');

figure(2), clf, land;
loglog(freq, pow, 'linewidth',LW);
xlabel('Frequency [Hz]');
ylabel('Power Spectrum [1/Hz]');
title('Power spectral density plot of x(t)');
fontchan(FS);

%% Part c) Butterworth filter

%response function
fc = [10 20];
Foo = 5;
[aa, bb] = butter(Foo, fc/(fsamp/2));
[HH, fr] = freqz(aa, bb);

figure(3), clf, land;
plot(fr, abs(HH), 'linewidth', LW);
xlabel('Frequency [Hz]');
ylabel('H(\omega)');
axis([0, .5, 0, 1.2]);
title('Butterworth Filter');
fontchan(FS);

%filtered time series
xfilt = filtfilt(aa,bb,xx_t);
[powfil, freqfil] = pwelch(xfilt, NFFT, NFFT/2, NFFT, fsamp);

figure(4), clf, land;
plot(time, xfilt)
axis([-1 1 -1 1]);
xlabel('Time [s]');
ylabel('Filtered Time Series');
title('Time Series Filtered with Butterworth');
fontchan(FS);


%% Part d) Filtered PSD

figure(5), clf, land;
loglog(freq, pow, 'linewidth',LW); hold on;
loglog(freqfil, powfil, 'linewidth',LW);
xlabel('Frequency [Hz]');
ylabel('Power Spectrum [1/Hz]');
title('Power spectral density plot of Butterworth filtered time series');
legend('Original time series', 'Filtered time series', 'Location', 'best');
fontchan(FS);


%% Part e) Difference plot

figure(6), clf, land;
plot(time, xfilt-x1_t);
xlabel('Time [s]');
ylabel('x(t)');
axis([-15 15 -1 1]);
title('Difference plot of x_1(x) and x_f(t)');
fontchan(FS)

%% Part f) Rectangular Filter
%nyquist frequency
fN = fsamp/2;
frequency = fsamp/NN*[-NN/2:-1, 1:NN/2];
%creating filter 
boxFilt = zeros(length(frequency), 1);
for i = 1:length(boxFilt)
   if (i >= 300 && i <= 600) || (i >= 29400 && i <= 29700)
       boxFilt(i) = 1;
   end
end

figure(7), clf, land;
plot(frequency, boxFilt);
xlabel('Frequency [Hz]');
ylabel('Box Filter');
title('Symmetric Boxcar filter');
fontchan(FS)

%making filtered time series
FT_xt = fft(xx_t);
filter_ts = ifft(FT_xt.*boxFilt');

figure(8), clf, land;
plot(time, real(filter_ts))
axis([-1 1 -1 1]);
xlabel('Time [s]');
ylabel('Filtered Time Series');
title('Time Series Filtered with Boxcar');
fontchan(FS);


%% Part g) Rectangular filtered PSD and difference plot

[pfil, ffil] = pwelch(real(filter_ts), NFFT, NFFT/2, NFFT, fsamp, 'onesided');

figure(9), clf, land;
loglog(freq, pow, 'linewidth',LW);hold on;
loglog(ffil, real(pfil), 'linewidth',LW); 
xlabel('Frequency [Hz]');
ylabel('Power Spectrum [1/Hz]');
title('Power spectral density plot of Boxcar filtered time series');
legend('Original time series', 'Filtered time series', 'Location', 'best');
fontchan(FS);

figure(10), clf, land;
plot(time, real(filter_ts-x1_t));
xlabel('Time [s]');
ylabel('x(t)');
title('Difference plot of x_1(x) and x_f(t)');
fontchan(FS);





