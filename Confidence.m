%% Confidence Interval Calculator, Joe Howie Oct 2nd, 2018
%%
function CI = confidence95(vec)
mns = samMeanStd(vec);
m = mns(1);
s = mns(2);
N = length(vec);
z = [-1.96, 1.96];
CI = m + z*s/sqrt(N);
return
end