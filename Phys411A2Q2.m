%% Assignment 2 Question 2, Joe Howie Oct 2nd, 2018
%%
clc; % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
LW =1;
FS = 18;
%% Minute Data
Min_data = load('UVicSci_temperature.dat');
%parsing
data_points = Min_data(3);
timeSpan_mins = linspace(Min_data(1), Min_data(2), data_points)-7/24;
temp_data = Min_data([4:data_points+3]);

%2015
start_minute_15 = datenum(2015,8,7,0,0,0);
end_minute_15 = datenum(2015,8,7,23,59,59);

time_index_m_15 = find(timeSpan_mins >= start_minute_15 & ...
timeSpan_mins <= end_minute_15);

time_min_15  = timeSpan_mins(time_index_m_15);
temp_min_15 = temp_data(time_index_m_15);

%2017
start_minute_17 = datenum(2017,8,7,0,0,0);
end_minute_17 = datenum(2017,8,7,23,59,59);

time_index_m_17 = find(timeSpan_mins >= start_minute_17 & ...
timeSpan_mins <= end_minute_17);

time_min_17  = timeSpan_mins(time_index_m_17);
temp_min_17 = temp_data(time_index_m_17);

%time series plot 2015
figure(1),clf,land;  hold on;%-- set paper orientation to landscape
plot(time_min_15,temp_min_15,'b-','linewidth',LW)
xlabel('Time [local]');
ylabel('Temperature [^oC]');
title('UVic weather data minute resolution 2015/08/07');
datetick('x');
fontchan(FS);

%time series plot 2017
figure(2),clf,land;  hold on;%-- set paper orientation to landscape
plot(time_min_17,temp_min_17,'b-','linewidth',LW)
xlabel('Time [local]');
ylabel('Temperature [^oC]');
title('UVic weather data minute resolution 2017/08/07');
datetick('x');
fontchan(FS);

%Solution
mns_min_15 = samMeanStd(temp_min_15);
mns_min_17 = samMeanStd(temp_min_17);
CI_min_15 = Confidence(temp_min_15);
CI_min_17 = Confidence(temp_min_17);
disp('On August 7th 2015 and 2017:')
fprintf('The mean for the 2015 minute data was %4.4f[Degrees]. \n', [mns_min_15(1)]);
fprintf('The mean for the 2017 minute data was %4.4f[Degrees]. \n', [mns_min_17(1)]);
fprintf('The confidence interval for the 2015 minute data was ');
fprintf('(%4.4f, %4.4f)[Degrees]. \n', [CI_min_15(1), CI_min_15(2)]);
fprintf('The confidence interval for the 2017 minute data was ')
fprintf('(%4.4f, %4.4f)[Degrees].\n', [CI_min_17(1), CI_min_17(2)]);
disp('Since the confidence intervals do not overlap, ');
disp('we can say that August 7th was hotter in 2017 than 2015 with 95 percent confidence.');

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

%2015
station_temp_15 = all_temps(:,station_index);    %-- temperature record at station
tt_start_15 = datenum(2015,8,7,0,0,0);
tt_end_15   = datenum(2015,8,7,23,59,59);
time_index_h_15 = find(tt_all >= tt_start_15 & tt_all <= tt_end_15);  %-- indices of desired time stamps
time_hour_15  = tt_all(time_index_h_15);
temp_hour_15 = station_temp_15(time_index_h_15);

%2017
station_temp_17 = all_temps(:,station_index); %-- temperature record at station
tt_start_17 = datenum(2017,8,7,0,0,0);
tt_end_17 = datenum(2017,8,7,23,59,59);
time_index_h_17 = find(tt_all >= tt_start_17 & tt_all <= tt_end_17);  %-- indices of desired time stamps
time_hour_17  = tt_all(time_index_h_17);
temp_hour_17 = station_temp_17(time_index_h_17);

figure(3),clf,land; hold on;  %-- set paper orientation to landscape
plot(time_hour_15,temp_hour_15,'b-','linewidth',LW);
xlabel('Time [local]');
ylabel('Temperature [^oC]');
title('UVic weather data hour resolution 2015/08/07');
datetick('x');
fontchan(FS)

%2017
figure(4),clf,land; hold on;  %-- set paper orientation to landscape
plot(time_hour_17,temp_hour_17,'b-','linewidth',LW);
xlabel('Time [local]');
ylabel('Temperature [^oC]');
title('UVic weather data hour resolution 2017/08/07');
datetick('x');
fontchan(FS)

%Solution
mns_hour_15 = samMeanStd(temp_hour_15);
CI_hour_15 = Confidence(temp_hour_15);
mns_hour_17 = samMeanStd(temp_hour_17);
CI_hour_17 = Confidence(temp_hour_17);
disp('On August 7th 2015 and 2017:')
fprintf('The mean the for 2015 hour data was %4.4f[Degrees]. \n', [mns_hour_15(1)]);
fprintf('The mean the for 2017 hour data was %4.4f[Degrees]. \n', [mns_hour_17(1)]);
fprintf('The confidence interval for the 2015 hour data was ');
fprintf('(%4.4f, %4.4f)[Degrees]. \n', [CI_hour_15(1), CI_hour_15(2)]);
fprintf('The confidence interval for the 2017 hour data was ')
fprintf('(%4.4f, %4.4f)[Degrees].\n', [CI_hour_17(1), CI_hour_17(2)]);
disp('Since the confidence intervals do overlap, ');
disp('we cannot say August 7th was hotter or colder in 2017 than 2015 with 95 percent confidence.')

