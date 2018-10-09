%% Linear Regression Coeficient calculator, Joe Howie Oct 2nd, 2018
%%
function coef = LinReg(vec1, vec2)
mns1 = samMeanStd(vec1);
mns2 = samMeanStd(vec2);
mean1 = mns1(1);
mean2 = mns2(1);
nums = length(vec1);
y_s = 0;
x_s = 0;
for c = 1:nums
    y_s = y_s + (vec2(c)-mean2)*vec1(c);
    x_s = x_s + (vec1(c)-mean1)*vec1(c);
end
b = y_s/x_s;
a = mean2-b*mean1;
coef = [a, b];
return
end