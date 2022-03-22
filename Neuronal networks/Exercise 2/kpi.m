% KPI
clc
clear all
close all

load('KPI_data.mat')
TP = 0;
FP = 0;
FN = 0;
TN = 0;

output=classifier1_output>=0.5;

for i = 1:length(realValues);
    if realValues(i) == 1 && output(i) == 1
        TP = TP + 1;
    elseif realValues(i) == 0 && output(i) ~= realValues(i)
        FP = FP + 1;
    elseif realValues(i) == 1 && output(i) ~=  realValues(i)
        FN = FN + 1;
    else 
        TN = TN + 1;
    end
end

%  Add code - calculate KPI

accuracy = (TP + TN)/1000;
precision = TP/(TP + FP);
recall = TP/(TP + FN);

% Add code - calculate F-Measure

f = 2*precision*recall/(precision + recall);

fprintf('the accuracy of the classifier is %0.3g. \n',accuracy)
fprintf('the precision of the classifier is %0.3g. \n',precision)
fprintf('the recall of the classifier is %0.3g. \n',recall)
fprintf('the F-Measure of the classifier is %0.3g. \n',f)



