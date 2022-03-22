clear all;
close all;
clc

%% Load the data
load('trainData.mat')

%% Plot the data
figure;
scatter(train_X,train_t)
ylabel('House Price (in 1M$)');
xlabel('Salary (in 1K$)');
title('Mazda train_ts')

%% Initialize the parameters
W = [0;0];
lambda = 0.01;

%% Plot the prediction
figure;
plotWithPrediction(train_X,train_t,W);

%% Use gradient descent to find  the optimal weights
numOfEpochs = 100;
error = zeros(1,numOfEpochs);
for epoch = 1:numOfEpochs
    [error(epoch), W] = doBatchGD(train_X,train_t,W,lambda, epoch);
end

%% Plot the prediction
plotWithPrediction(train_X,train_t,W);

%% plot the error function
figure;
plot(1:numOfEpochs,error);
ylabel('Error');
xlabel('Epoch');
title('Error function values');

% Predict the test data.
load('testData.mat');

test_error = predictTestData(test_X, test_t, W);

disp(['Training error: ', num2str(error(end),3)]);
disp(['Test error: ', num2str(test_error,3)]);