%% Assignment 4 Question 1
%%
clc; % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
LW =1;
FS = 18;
%% Hour Data
file = '/Users/josephhowie/Uvic/5th_year/Fall2018/Phys411/AllStations_temperature_h_2017.dat';

All_hour_data = load(file);

[rows,cols] = size(All_hour_data);  

tt_all = All_hour_data(3:rows,1); 
%look up station by longitude (lon) and latitude (lat)
Station_lon_all = All_hour_data(1,2:cols);  %- longitudes (all stations) (are in the first row)
Station_lat_all = All_hour_data(2,2:cols);  %- latitudes (all stations) (are in the second row)

Num_stations = length(Station_lat_all);  %-- number of stations
data_pts_per_station = length(tt_all);   %-- number of data points in each station (number of time stamps)
 
all_temps = All_hour_data(3:rows,2:cols); %-- matrix with temperature data only.

station_lon = 236.691;  %-- you have to specify this!
station_lat =  48.462;  %-- you have to specify this!

%-- find the station which has the smallest deviation from the desired lat, lon values
diff_lon = abs(Station_lon_all - station_lon);  
diff_lat = abs(Station_lat_all - station_lat);  

[~,station_index] = min(diff_lon+diff_lat); %--finds closest station

% Winter
station_temp_15 = all_temps(:,station_index);    %-- temperature record at station
tt_start_15 = datenum(2015,12,1,0,0,0);
tt_end_15   = datenum(2016,2,29,23,59,59);
time_index_h_15 = find(tt_all >= tt_start_15 & tt_all <= tt_end_15);  %-- indices of desired time stamps
time_hour_15  = tt_all(time_index_h_15);
temp_hour_15 = station_temp_15(time_index_h_15);

% Spring
station_temp_16 = all_temps(:,station_index); %-- temperature record at station
tt_start_16 = datenum(2016,6,1,0,0,0);
tt_end_16 = datenum(2016,8,31,23,59,59);
time_index_h_16 = find(tt_all >= tt_start_16 & tt_all <= tt_end_16);  %-- indices of desired time stamps
time_hour_16 = tt_all(time_index_h_16);
temp_hour_16 = station_temp_16(time_index_h_16);

%{
figure(1),clf,land; hold on;  %-- set paper orientation to landscape
plot(time_hour_15,temp_hour_15,'b-','linewidth',LW);
xlabel('Time [local]');
ylabel('Temperature [^oC]');
title('UVic weather data from 2015/12/1 to 2016/03/1');
datetick('x');
fontchan(FS)

figure(2),clf,land; hold on;  %-- set paper orientation to landscape
plot(time_hour_16,temp_hour_16,'b-','linewidth',LW);
xlabel('Time [local]');
ylabel('Temperature [^oC]');
title('UVic weather data from 2016/06/01 to 2016/09/01');
datetick('x');
fontchan(FS)
%}

%% Part a) Power spectrum 
%demean timeseries
temp_hour_15 = temp_hour_15 - mean(temp_hour_15);
temp_hour_16 = temp_hour_16 - mean(temp_hour_16);

NFFT15 = 2^(nextpow2(length(temp_hour_15))-1);
NFFT16 = 2^(nextpow2(length(temp_hour_16))-1);

[pow15, freq15, ci15] = pwelch(temp_hour_15, NFFT15, NFFT15/2, NFFT15, 1/3600);
[pow16, freq16, ci16] = pwelch(temp_hour_16, NFFT16, NFFT16/2, NFFT16, 1/3600);

figure(3),clf,land;
loglog(freq15, pow15); hold on;
hp = patch([freq15(2:end); freq15(end:-1:2); freq15(2)], [ci15(2:end,1); ci15(end:-1:2,2); ci15(2,1)], 'r');
set(hp,'facecolor',[1,1,1]*0.8,'edgecolor','none');
loglog(freq15, pow15);
xlabel('Frequency [Hz]');
ylabel('Power Spectra [(C^o)^2/Hz]');
title('UVic weather data Winter Hour Resolution');
fontchan(FS)

figure(4), clf, land;
loglog(freq16, pow16); hold on;
hp = patch([freq16(2:end); freq16(end:-1:2); freq16(2)], [ci16(2:end,1); ci16(end:-1:2,2); ci16(2,1)], 'r');
set(hp,'facecolor',[1,1,1]*0.8,'edgecolor','none');
loglog(freq16, pow16);
xlabel('Frequency [Hz]');
ylabel('Power Spectra [(C^o)^2/Hz]');
title('UVic weather data Summer Hour Resolution');
fontchan(FS)


%% Part b) Variance

figure(5), clf, land;
semilogx(freq16, freq16.*pow16); hold on;
semilogx(freq15, freq15.*pow15); 
xlabel('Frequency [Hz]');
ylabel('Power Spectra * frequency [C^2]');
title('f*psd vs log frequency');
legend('Summer', 'Winter')
fontchan(FS)




%% Part c) Minute power spectrum

Min_data = load('UVicSci_temperature.dat');
%parsing
data_points = Min_data(3);
timeSpan_mins = linspace(Min_data(1), Min_data(2), data_points)-7/24;
temp_data = Min_data([4:data_points+3]);

%2015
start_minute_15 =datenum(2015,12,1,0,0,0);
end_minute_15 = datenum(2016,2,29,23,59,59);

time_index_m_15 = find(timeSpan_mins >= start_minute_15 & ...
timeSpan_mins <= end_minute_15);

time_min_15  = timeSpan_mins(time_index_m_15);
temp_min_15 = temp_data(time_index_m_15);

%2016
start_minute_16 = datenum(2016,6,1,0,0,0);
end_minute_16 = datenum(2016,8,31,23,59,59);

time_index_m_16 = find(timeSpan_mins >= start_minute_16 & ...
timeSpan_mins <= end_minute_16);

time_min_16  = timeSpan_mins(time_index_m_16);
temp_min_16 = temp_data(time_index_m_16);

%remove nan
temp_min_15(isnan(temp_min_15)) = [];
temp_min_16(isnan(temp_min_16)) = [];

%demean 
temp_min_15 = temp_min_15 - mean(temp_min_15);
temp_min_16 = temp_min_16 - mean(temp_min_16);

NF15 = 2^(nextpow2(length(temp_min_15))-1);
NF16 = 2^(nextpow2(length(temp_min_16))-1);

[powm15, freqm15, cim15] = pwelch(temp_min_15, NF15, NF15/2, NF15, 1/60);
[powm16, freqm16, cim16] = pwelch(temp_min_16, NF16, NF16/2, NF16, 1/60);


figure(6),clf,land;
loglog(freqm15, powm15); hold on;
hp = patch([freqm15(2:end); freqm15(end:-1:2); freqm15(2)], [cim15(2:end,1); cim15(end:-1:2,2); cim15(2,1)], 'r');
set(hp,'facecolor',[1,1,1]*0.8,'edgecolor','none');
loglog(freqm15, powm15);
xlabel('Frequency [Hz]');
ylabel('Power Spectra [(C^o)/Hz]');
title('UVic weather data Winter Minute Resolution');
fontchan(FS)

figure(7), clf, land;
loglog(freqm16, powm16); hold on;
hp = patch([freqm16(2:end); freqm16(end:-1:2); freqm16(2)], [cim16(2:end,1); cim16(end:-1:2,2); cim16(2,1)], 'r');
set(hp,'facecolor',[1,1,1]*0.8,'edgecolor','none');
loglog(freqm16, powm16);
xlabel('Frequency [Hz]');
ylabel('Power Spectra [(C^o)/Hz]');
title('UVic weather data Summer Minute Resolution');
fontchan(FS)


