%% Assignament 1, Question 4 Full data sets

% Minute analysis

clc; % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.

Min_data = load('UVicSci_temperature.dat');
%parsing
start_minute = Min_data(1);
end_minute = Min_data(2);
data_pts = Min_data(3);
timeSpan_mins = linspace(start_minute, end_minute, data_pts);
temp_data = Min_data([4:data_pts+3]);

LW = 1;  %-- line width
FS = 18; %-- fontsizeç

%time series plot
figure(1),clf,land  %-- set paper orientation to landscape
plot(timeSpan_mins,temp_data,'b-','linewidth',LW)
xlabel('Time [local]')
ylabel('Temperature [^oC]')
title('UVic weather data minute resolution')
datetick('x')
fontchan(FS)

%histogram plot
rang= [-10: .1: 40];
norm = normpdf(rang, 11.295, 5.609);
figure(3); hold on;
plot(rang, norm, 'linewidth',3)
histogram(temp_data,100, 'Normalization', 'pdf')
title('Minute data for 2010/01/01 to 2017/08/30')
xlabel('Temperature [^oC]');
ylabel('Events')
fontchan(FS)
%prints sample mean and std
mns_1 = samMeanStd(temp_data);

display(sprintf('Minute resolution mean %4.3f [Celsius], %4.3f [Celsius]',[mns_1(1), mns_1(2)]));


% Hour analysis
%----------------------------------------------------------------------------
%--   E:\JOHANNES\Phys411\Matlab_examples\readHourlyData.m
%--
%--   Purpose: to load hourly sampled temperature data
%--    and to extract data for a specific station
%-- 
%--  Input: AllStations_temperature_h.dat
%--
%--   11/09/2018                                       J.Gemmrich
%----------------------------------------------------------------------------

fdrivein = '/Users/josephhowie/Uvic/5th_year/Fall2018/Phys411/';  %-- file input directory (need to specify this)

fnamein = 'AllStations_temperature_h_2017';   %-- name of input file (with data for all stations)

extin = '.dat';                          %-- extension of input file name

%----------------------------
%-- load all data into a single matrix
%----------------------------

All_hour_data = load([fdrivein,fnamein,extin]);


[rows,cols] = size(All_hour_data);  %-- InH has NN rows and MM columns


%---------------------------
%-- seperate input matrix into time stamps, station coordinates and temperature data
%---------------------------


tt_all = All_hour_data(3:rows,1);  %-- time stamps {decimal days,Matlab format] (are in the first column)

Station_lon_all = All_hour_data(1,2:cols);  %- longitudes (all stations) (are in the first row)
Station_lat_all = All_hour_data(2,2:cols);  %- latitudes (all stations) (are in the second row)


Num_stations = length(Station_lat_all);  %-- number of stations
data_pts_per_station = length(tt_all);   %-- number of data points in each station (number of time stamps)



%-------------------------------------------------------
%-- There are NS different stations in this data set
%-- each station is 1 column
%--------------
%-- first 2 rows give longitude and latitude for each station
%--------------
%-- first column gives time stamps
%-------------------------------------------------------

 %-- so this leaves NN-2 data points (temperature) for each station
 
 all_temps = All_hour_data(3:rows,2:cols); %-- matrix with temperature data only.
 

%--------------------------
%-- pick 1 specific stations, based on its coordinates
%--------------------------

station_lon = 236.691;  %-- you have to specify this!
station_lat =  48.462;  %-- you have to specify this!

%(for another station this might be as follows:)
% % station_lon = 236.691;  %-- you have to specify this!
% % station_lat =  48.462;  %-- you have to specify this!


%-- find the station which has the smallest deviation from the desired lat, lon values
diff_lon = abs(Station_lon_all - station_lon);  
diff_lat = abs(Station_lat_all - station_lat);  

[~,station_index] = min(diff_lon+diff_lat);
     %-- iis is the index of the desired station (column number in TTH_all)


 station_temp = all_temps(:,station_index);    %-- temperature record at station


%---------------------------------------------
%-- Next, find a specific time interval
%---------------------------------------------

tt_start = datenum(2010,1,1,0,0,0);
tt_end   = datenum(2017,8,31,0,0,0);


time_index = find(tt_all >= tt_start & tt_all <= tt_end);  %-- indices of desired time stamps


time_i  = tt_all(time_index);
temp_i = station_temp(time_index);


%--------------------

%-- display time series with some custom settings 
%-- (need to download 'land.m', 'port.m' and 'fontchan.m' from course home page
%--------------------

%time series
figure(2),clf,land  %-- set paper orientation to landscape
 plot(time_i,temp_i,'r-','linewidth',LW)
 xlabel('Time [local]')
 ylabel('Temperature [^oC]')
 title( sprintf('Hour resolution recorded at %4.3f N, %4.3f W',[Station_lat_all(station_index),360-Station_lon_all(station_index)]) )
 datetick('x')
 fontchan(FS)

%histogram plot
figure(4); hold on;
norm_2 = normpdf(rang, 11.095, 5.477);
plot(rang, norm_2, 'linewidth',3)
histogram(temp_i,100,'Normalization', 'pdf')
title('Hour data for 2010/01/01 to 2017/08/30')
xlabel('Temperature [^oC]');
ylabel('Events')
fontchan(FS)
%prints sample mean and std
mns_2 = samMeanStd(temp_i);
display(sprintf('Hour resolution mean %4.3f [Celsius], %4.3f [Celsius]',[mns_2(1), mns_2(2)]));