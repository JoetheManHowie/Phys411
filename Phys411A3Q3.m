%% Assignment 3 Question 3
%%
clc; % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
LW =1;
FS = 18;


%% The time series
y_val = 1*ones(1,100);
T = 1;

figure(1); clf; land; hold on;
plot(linspace(-3*T/2, -T, 100), -y_val, 'r')
plot(linspace(-T, -T/2, 100), y_val, 'r')
plot(linspace(-T/2, 0, 100), -y_val, 'r')
plot(linspace(0, T/2, 100), y_val, 'r')
plot(linspace(T/2, T, 100), -y_val, 'r')
plot(linspace(T, 3*T/2, 100), y_val, 'r'); hold off;
xlabel('Time [s]')
ylabel('x(t)')
title('Time series x(t)')
fontchan(FS)
axis([-3*T/2 3*T/2 -3*T/2 3*T/2]);

%% the fourier series
FT_x = zeros(1,600);
time = linspace(-3*T/2,3*T/2, 600);
figure(2);clf; land; hold on;
for a = 0:100
    if (mod(a,2) == 1)
        Sm = 4/(pi*a);
        FT_x = FT_x + Sm*sin(2*pi*a*time/T);
    end
    if (a == 1 || a == 2 || a == 5 || a == 10 || a == 100)
        plot(time, FT_x, 'linewidth',LW)
        xlabel('Time [s]')
        ylabel('Fourier series of x(t)')
        title('Fourier series approximation with different number of terms')
        fontchan(FS)
        axis([-3*T/2 3*T/2 -2, 2]);
        
    end
end
legend('a = 1', 'a = 2', 'a = 5', 'a = 10', 'a = 100');
hold off;


%% Power Spectrum
t2 = [0:pi/200:100*pi];
NFFT1 = size(t2,2);

terms = [5 100];
tit = {'Power Spectrum with 5 terms' 'Power Spectrum with 100 terms'};

time_2 = [0:T/200:100*T];
FT_x = zeros(1,length(time_2));
fig_num = 3;
for i = 1:length(terms)
    for a = 0:terms(i) 
        if (mod(a,2) == 1)
            Sm = 4/(pi*a);
            FT_x = FT_x + Sm*sin(2*pi*a*time_2/T);
        end
    end
    [pow,freq] = pwelch(FT_x,NFFT1,NFFT1/2,NFFT1,1/200,'onesided');
    figure(fig_num); clf; land;
    loglog(freq,pow,'-')
    xlabel('Frequency (Hz)')
    ylabel('Power spectrum')
    title(tit(i))
    fontchan(FS)
    fig_num = fig_num + 1;
       
end
