%% Correlation Coefiicient Calculator, Joe Howie Oct 2nd, 2018
%%
function r_xy = corrCoef(vec1, vec2)
mns_1 = samMeanStd(vec1);
mns_2 = samMeanStd(vec2);
mean1 = mns_1(1);
mean2 = mns_2(1);
std1 = mns_1(2);
std2 = mns_2(2);
nums = length(vec1);
sum = 0;
for c = 1:nums
    sum = sum + (vec1(c)-mean1)*(vec2(c)-mean2);
end
r_xy = (sum)/((nums-1)*std1*std2);
return 
end