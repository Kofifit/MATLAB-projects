function [ypred,regAccuracy]=predTest(xtest, ytest, th)

% This function get three inputs - a matrix of predictors of test set, a 
% vector of the real labels of test set and a vector of theta (weights).
% The output is a vector of the prediction and the accuracy of that
% prediction.
% The function predicts the labels with the theta input and 'sigmoid'
% function.

[hp]=sigmoid(xtest*th); % Hypothesis Function
ypred = zeros(size(ytest));
ypred(hp>=0.5)=1;
ypred(hp<0.5)=0;
score = 0;

for i = 1:length(ytest)
    if ypred(i) == ytest(i)
        score = score + 1;
    end
end

regAccuracy = 100*score/length(ytest);

