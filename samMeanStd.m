%% Homebrew mean and std estimation function, Joe Howie Oct 2nd, 2018
%%
function mns = samMeanStd(vec)
mns = ones(2:1);
vec(isnan(vec)) = [];
sum = 0;
nums = length(vec);
for i=1:nums
    sum = sum + vec(i);
end
%this is a number I want.
sam_mean = sum/nums;
mns(1) = sam_mean;
diff_sum = 0;
for i=1:nums
    diff_sum = diff_sum + (vec(i)-sam_mean).^2;
end
%this is a number I want
sam_std = sqrt(1/(nums-1)*diff_sum);
mns(2) = sam_std;
return
end