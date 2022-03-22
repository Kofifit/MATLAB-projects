function [bestSVM] = svmModel(subSets_training,subSets_validation)

% This function gets two inputs - a 5 cell array with training subsets
% (1351-1352 observations in each cell) and 5 cell array with validation
% subsets (337-338 observations in each cell).
% The output of the function is best SVM model from section 3.
% This function create svm models with 'fitcsvm' function.
% Section 1 - Creates svm models for each fold (5 folds). For each fold
% it accumlates the number of observations, starting from 10 and adding 10
% each iteration. At the end, for each fold 136 svm models are built. In
% addition, it calculates training error with 'resubloss' function and
% validation error with 'loss' function. At the end, it plots the training
% and validation error on a graph.
% Section 2 - Trains svm models with regularization. In addition, it 
% calculates training error with 'resubloss' function and validation error
% with 'loss' function. At the end, it plots the training and validation
% error on a graph.
% Section 3 - Conducts random search for hyperparameters, for svm models
% that were trained on all the observations in the training subset (1352).
% 5 models are built. In addition, it calculates training error with
% 'resubloss' function and validation error with 'loss' function. The svm
% model with the lowest validation error is going to be the output of the
% function (bestSVM).

%% Create SVM models - question 4

% Create cell array for all SVM models
svmModel = cell(1,1);
error_training = zeros(1,1);
error_validation = zeros(1,1);

% Define response and predictor variables in a formula form for fitcsvm func
strNames = 'NObeyesdad~family_history_with_overweight+FrequentConsumptionOfHighCaloricFood_FAVC_+FrequencyOfConsumptionOfVegetables_FCVC_+NumberOfMainMeals_NCP_+ConsumptionOfFoodBetweenMeals_CAEC_+SMOKE+ConsumptionOfWaterDaily_CH20_+CaloriesConsumptionMonitoring_SCC_+PhysicalActivityFrequency_FAF_+TimeUsingTechnologyDevices_TUE_+ConsumptionOfAlcohol_CALC_+MTRANS';

% Loop to create SVM models and find error for training and validation
for j = 1:5
    counter = 10; % Create counter
    current_trainingSet = subSets_training{j}; % Define current training set
    for i = 1:ceil(size(current_trainingSet,1)/counter) % accumulate observation #
        if counter < size(current_trainingSet,1)
            % Create SVM model
            svmModel{i,j} = fitcsvm(current_trainingSet(1:counter,:),...
                strNames,'KernelFunction','gaussian','BoxConstraint',50);
            counter = counter + 10;
        else
            % Create SVM model
            svmModel{i,j} = fitcsvm(current_trainingSet(1:end,:),...
                strNames,'KernelFunction','gaussian','BoxConstraint',50);
        end
        error_training(i,j) = resubLoss(svmModel{i,j}); % training error
        error_validation(i,j) = loss(svmModel{i,j},subSets_validation{j}); % validation error
    end
end


% Find variance between all models
modelsVar_training = mean(var(error_training,0,2)); % Training variance
modelsVar_validation = mean(var(error_validation,0,2)); % Validation variance

% Plot training and validation error
x = [10:10:1350, 1352];
figure
plot(x,mean(error_training,2)*100,'b'); % Plot training error
hold on
plot(x,mean(error_validation,2)*100,'r'); % Plot validation error
xlabel('Number of observations');
ylabel('Error (percentage)');
title('Error in SVM without regularization');
xlim([10 1352]);
ylim([0 80]);
legend({'Training error' 'Validation error'});

%% Regularization - question 5

% Create cell array for all the SVM models with reugularization
svmModelReg = cell(1,1);
error_trainingReg = zeros(1,1);
error_validationReg = zeros(1,1);

% Loop to create SVM models and find error for training and validation
for j = 1:5
    counter = 10; % Create counter
    current_trainingSet = subSets_training{j}; % Define current training set
    for i = 1:ceil(size(current_trainingSet,1)/counter)
        if counter < size(current_trainingSet,1)
            % create SVM model with 'BoxConstraint' as 1 (Regularization)
            svmModelReg{i,j} = fitcsvm(current_trainingSet(1:counter,:),...
                strNames,'KernelFunction','gaussian','BoxConstraint',1);
            counter = counter + 10;
        else
            % create SVM model with 'BoxConstraint' as 1 (Regularization)
            svmModelReg{i,j} = fitcsvm(current_trainingSet(1:end,:),...
                strNames,'KernelFunction','gaussian','BoxConstraint',1);
        end
        error_trainingReg(i,j) = resubLoss(svmModelReg{i,j}); % Training error
        error_validationReg(i,j) = loss(svmModelReg{i,j},subSets_validation{j}); % Validation error
    end
end


% Find variance between all SVM models
modelsVar_trainingReg = mean(var(error_trainingReg,0,2)); % training variance
modelsVar_validationReg = mean(var(error_validationReg,0,2)); % validation variance

% Plot training and validation error
x = [10:10:1350, 1352];
figure
plot(x,mean(error_trainingReg,2)*100,'b'); % Plot training error
hold on
plot(x,mean(error_validationReg,2)*100,'r'); % Plot validation error
xlabel('Number of observations');
ylabel('Error (percentage)');
title('Error in SVM with regularization');
xlim([10 1352]);
ylim([0 80]);
legend({'Training error' 'Validation error'});

%% Optimize hyperparameters - question 6


% Create cell array for all the SVM models
svmModelOpt = cell(1,1);
error_trainingOpt = zeros(1,1);
error_validationOpt = zeros(1,1);

% Loop to create SVM models and find error for training and validation
for i = 1:5
    current_trainingSet = subSets_training{i}; % Define current training set
    % Create SVM model with optimization of hyperparameters
    svmModelOpt{i} = fitcsvm(current_trainingSet,strNames,...
        'OptimizeHyperparameters',{'BoxConstraint' 'KernelScale'...
        'KernelFunction'},'HyperparameterOptimizationOptions',...
        struct('optimizer','randomsearch', 'MaxObjectiveEvaluations',20));
    error_trainingOpt(i) = resubLoss(svmModelOpt{i}); % Training error
    error_validationOpt(i) = loss(svmModelOpt{i},subSets_validation{i}); % Validation error
end

%% Find the best SVM model for future predictions - for questions 9 & 10

bestIndex = find(min(error_validationOpt)); % model with minimal validation error
bestSVM = svmModelOpt{bestIndex}; % assign model to function output