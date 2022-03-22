
%% Clean
clear all
close all
clc

%% Prepare data with function prepareData - Question 2
[subSets_training,subSets_validation,data_train,data_test] = prepareData();

%% Scatter three predictors that seem the most relevant  - Question 3
plotScatter(data_train);

%% Create trees models and get the best tree model (lowest validtion error)
% Questions 4,5,6 - Decision tree model
[bestTree] = decisionTreeModel(subSets_training,subSets_validation);

%% Create SVM models and get the best SVM model (lowest validation error)
% Questions 7 (4,5,6) - SVM model
[bestSVM] = svmModel(subSets_training,subSets_validation);

%% Create logistic regression model and get the best regression model (lowest validation error)
% Questions 8 (4,5,6) - Logistic regression model
[bestLogisticRegression,xtest,ytest] = logisticRegressionModel(subSets_validation,data_test);

%% Questions 9 & 10
bestModels = {bestTree, bestSVM, bestLogisticRegression};
ensembleModelandAccuracy(bestModels,data_test,xtest,ytest);



