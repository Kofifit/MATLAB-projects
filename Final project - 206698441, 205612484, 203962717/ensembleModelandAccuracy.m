function [] = ensembleModelandAccuracy(bestModels,data_test,xtest,ytest)

% This function gets 4 inputs - All best models (Decision Tree, SVM,
% Logistic Regression), the test set in a table, a double matrix of test
% set predictors, a double vector of test set real labels (y). The function
% has no output. 
% At first the function predicts the labels (obese/1 or healthy/0) with
% each model. Then the function craete ensemble model with the predictions
% of the models, while using the majority-rule.
% The function later calculats accuracy for each model (4 models) and plots
% the accuracies with a bar graph.


% QUESTION 10 
% Set initial parameters
realValues = data_test{:,17};
rowNum = size(data_test,1);
allPrediction = zeros(rowNum,3);
prediction = zeros(rowNum,1);
accuracyModels = zeros(1,4);

% Get prediction for test from each model
for i = 1:3
    if i < 3
        allPrediction(:,i) = predict(bestModels{i},data_test);
    else
        [allPrediction(:,i),regAccuracy] = predTest(xtest, ytest, bestModels{i});
    end
end

% Create ensemble model prediction based on majority
for i = 1:rowNum
    current = unique(allPrediction(i,:));
    if length(current) == 1 % same predition all models
        prediction(i) = current;
    elseif length(current) == 2 % same prediction 2 models - majority
        if length(find(allPrediction(i,:) == 1)) > 1
            prediction(i) = 1;
        else
            prediction(i) = 0;
        end
    end
end

% Calculate number of correctly classified observations with ensemble
score = 0;
for i = 1:rowNum
    if prediction(i) == realValues(i)
        score = score + 1;
    end
end

% QUESTION 9

% Calculate accuracy for each model
for i = 1:4
    if i < 3
        accuracyModels(i) = (1-loss(bestModels{i},data_test))*100;
    elseif i == 3
        accuracyModels(i) = regAccuracy;
    else
        accuracyModels(i) = 100*score/length(prediction);
    end
end

% Plot accuracies for each model on bar graph
modelNames = {'Decision Tree','SVM','Logistic Regression','Ensemble'};
figure
bar(1:4,accuracyModels);
xticklabels(modelNames);
xlabel('Model');
ylabel('Accuracy (percentage)');
title('Classification succuess for test set - compare between models');
ylim([0 100]);

