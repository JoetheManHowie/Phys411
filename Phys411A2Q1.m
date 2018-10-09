%%  Assignment 2 Question 1, Joe Howie Oct 2nd, 2018 
%%
clc; % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
FS = 18;

%% Part a) Scatter Plot
data = load('WindWaveData.txt');
wind_speed = data(:, 1);
wave_height = data(:,2);

figure(1), clf,land
scatter(wind_speed, wave_height);
xlabel('Wind Speed u (m/s)');
ylabel('Wave Height H (m)');
title('Scatter plot of wind speed against wave height');
fontchan(FS);
display('The data does not appear to be linearly correlated.')

%% Part b) correlation coefficient
r_uH = corrCoef(wind_speed, wave_height);
N = length(wind_speed);
in_CI = sqrt(N-3)/2*log((1+r_uH)/(1-r_uH));

fprintf('The Correlation coefficient is %4.4f. \n', r_uH)
fprintf('The confidence interval calculation gives a value of %4.4f, ')
fprintf('which is outside of the interval (-1.96, 1.96) \n',[in_CI]);
display('Thus, the correlation coefficient does indicate 95 percent ');
fprintf('confidence.')

%% Part c) Linear regression
LinCoefs = LinReg(wind_speed, wave_height);
a = LinCoefs(1);
b = LinCoefs(2);
fprintf('The linear regression coefficients a and b are %4.4f, ');
fprintf('and %4.4f respectively. \n',[a, b]);
fprintf('So the linear regression line equation is: ');
fprintf('H_s = %4.4f + %4.4fu. \n', [a, b]);

RegLine = a + b*wind_speed;
alpha = 0.05;
nums = length(wave_height);
s_ep = 0;
for c = 1:nums
    s_ep = s_ep + (wave_height(c) - RegLine(c))^2;
end
s_epsilon = sqrt(s_ep/(nums-2));
t = tinv([alpha/2, 1-alpha/2], nums-2);
mns_u = samMeanStd(wind_speed);
mean_u = mns_u(1);
std_u = mns_u(2);
delta_b = s_epsilon*t/(sqrt(nums-1)*std_u);
con_int_b = b + delta_b;

fprintf('The confidence interval for the slope of the regression line ');
fprintf('is (%4.4f, %4.4f). \n', [con_int_b(1), con_int_b(2)]);
%% Part d) Addition on the Regression line to scatter plot

figure(2), clf,land; hold on;
scatter(wind_speed, wave_height);
plot(wind_speed, RegLine);
xlabel('Wind Speed u (m/s)');
ylabel('Wave Height H (m)');
title('Scatter plot of wind speed against wave height');
legend('Wind Speed vs. Wave Height', 'Regression Line (RL)')
fontchan(FS);
%% Part e) Uncertainty on a and b
mns_H = samMeanStd(wave_height);
mean_H = mns_H(1);
std_H = mns_H(2);

delta_a = (b + delta_b)*mean_u + a - mean_H;
RegLine_unP = a + delta_a(2) + (b + delta_b(1))*wind_speed;
RegLine_unM = a + delta_a(1) + (b + delta_b(2))*wind_speed;

figure(3), clf,land; hold on;
scatter(wind_speed, wave_height);
plot(wind_speed, RegLine);
plot(wind_speed, RegLine_unP);
plot(wind_speed, RegLine_unM);
xlabel('Wind Speed u (m/s)');
ylabel('Wave Height H (m)');
legend('Wind Speed vs. Wave Height', 'Regression Line (RL)', ... 
'RL uncertainty (+\deltaa and -\deltab)',... 
'RL uncertainty (-\deltaa and +\deltab)');
title('Scatter plot of wind speed against wave height');
fontchan(FS);

%% Part f) uncertainty on b only
RegLine_unP_b = a + (b + delta_b(1))*wind_speed;
RegLine_unM_b = a + (b + delta_b(2))*wind_speed;

figure(4), clf,land; hold on;
scatter(wind_speed, wave_height);
plot(wind_speed, RegLine);
plot(wind_speed, RegLine_unP);
plot(wind_speed, RegLine_unM);
plot(wind_speed, RegLine_unP_b);
plot(wind_speed, RegLine_unM_b);
xlabel('Wind Speed u (m/s)');
ylabel('Wave Height H (m)');
legend('Wind Speed vs. Wave Height', 'Regression Line (RL)',...
'RL uncertainty (+\deltaa and -\deltab)',...
'RL uncertainty (-\deltaa and +\deltab)',...
'RL uncertainty in -\deltab only', 'RL uncertainty in +\deltab only');
title('Scatter plot of wind speed against wave height');
fontchan(FS);

%% Part g) Expected Range 

exp_ab = a - delta_a + (b + delta_b)*10;
exp_b = a + (b+ delta_b)*10;

fprintf('The expected range of wave heights for a wind speed of 10m/s is ');
fprintf('(%4.4f, %4.4f), for errors in a and b. \n', [exp_ab(1), exp_ab(2)]);
fprintf('The expected range of wave heights for a wind speed of 10m/s is ');
fprintf('(%4.4f, %4.4f), for errors in b only. \n', [exp_b(1), exp_b(2)]);


