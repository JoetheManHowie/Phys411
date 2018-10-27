%% Assignment 3 Question 2
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

figure(1),clf,land; hold on;  %-- set paper orientation to landscape
plot(time_hour_15,temp_hour_15,'b-','linewidth',LW);
xlabel('Time [local]');
ylabel('Temperature [^oC]');
title('UVic weather data from 2015/12/1 to 2016/03/1');
datetick('x');
fontchan(FS)

% Spring
station_temp_16 = all_temps(:,station_index); %-- temperature record at station
tt_start_16 = datenum(2016,6,1,0,0,0);
tt_end_16 = datenum(2016,8,31,23,59,59);
time_index_h_16 = find(tt_all >= tt_start_16 & tt_all <= tt_end_16);  %-- indices of desired time stamps
time_hour_16 = tt_all(time_index_h_16);
temp_hour_16 = station_temp_16(time_index_h_16);

figure(2),clf,land; hold on;  %-- set paper orientation to landscape
plot(time_hour_16,temp_hour_16,'b-','linewidth',LW);
xlabel('Time [local]');
ylabel('Temperature [^oC]');
title('UVic weather data from 2016/06/01 to 2016/09/01');
datetick('x');
fontchan(FS)
