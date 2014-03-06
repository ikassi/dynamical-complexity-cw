function [ ps MFR ] = LoadTrials()
%LoadTrials Load the trials from the stored Files
ps = importdata('./Q2/MFR/ps.mat');

for i = 1:length(ps)
    MFR{i} = importdata(['./Q2/MFR/MFR' num2str(i) '.mat']);
end

end

