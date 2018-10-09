%% Assignmant 1, question 2.
clc; % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.

ax_font = 18;
tit_font = 20;

size = 1000;
a = 1;
ran_nums = a*rand(size)-(0.5);

figure;
histogram(ran_nums);
ylabel('Entries','fontSize', ax_font);
xlabel('x (random numbers between (-a, a)','fontSize', ax_font);
title('Random number PDF','fontSize', tit_font);

range = 17;
b = 1;
for i = 2:range
    
    ran_nums = (ran_nums + (a*rand(size)-(0.5)))/sqrt(2); 

    if mod(i,2^b) == 0
        figure;
        histogram(ran_nums);
        axis([-1 1 0 inf]);
        ylabel('Entries','fontSize', ax_font);
        xlabel('x (random numbers between (-a, a)','fontSize', ax_font);
        title(strcat('Random number PDF, with ', num2str(i), ' random distributions summed'),'fontSize', tit_font);
        b = b + 1;
    end
end

        

