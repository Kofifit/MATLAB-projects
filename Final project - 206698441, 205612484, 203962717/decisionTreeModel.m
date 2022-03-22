function [bestTree] = decisionTreeModel(subSets_training,subSets_validation)

% This function gets two inputs - a 5 cell array with training subsets
% (1351-1352 observations in each cell) and 5 cell array with validation
% subsets (337-338 observations in each cell).
% The output of the function is best tree model from section 3.
% This function create tree models with 'fitctree' function.
% Section 1 - Creates tree models for each fold (5 folds). For each fold
% it accumlates the number of observations, starting from 10 and adding 10
% each iteration. At the end, for each fold 136 tree models are built. In
% addition, it calculates training error with 'resubloss' function and
% validation error with 'loss' function. At the end, it plots the training
% and validation error on a graph.
% Section 2 - Adds regularization to all tree models from section 1. 
% Regularization is added in the form of pruning. In addition, it 
% calculates training error with 'resubloss' function and validation error
% with 'loss' function. At the end, it plots the training and validation
% error on a graph.
% Section 3 - Conducts grid search for all hyperparameters, for tree models
% that were trained on all the observations in the training subset (1352).
% 5 trees are built. The trees are pruned after they're built. In addition,
% it calculates training error with 'resubloss' function and validation 
% error with 'loss' function. The tree with the lowest validation error is
% going to be the output of the function (bestTree).

%% Create tree models - question 4

% Create cell array for all the tree models
trees = cell(1,1);
error_training = zeros(1,1);
error_validation = zeros(1,1);

% Define response and predictor variables in a formula form for fitctree func
strNames = 'NObeyesdad~family_history_with_overweight+FrequentConsumptionOfHighCaloricFood_FAVC_+FrequencyOfConsumptionOfVegetables_FCVC_+NumberOfMainMeals_NCP_+ConsumptionOfFoodBetweenMeals_CAEC_+SMOKE+ConsumptionOfWaterDaily_CH20_+CaloriesConsumptionMonitoring_SCC_+PhysicalActivityFrequency_FAF_+TimeUsingTechnologyDevices_TUE_+ConsumptionOfAlcohol_CALC_+MTRANS';

% Loop to create tree models and find error for training and validation
for j = 1:5
    counter = 10; % Create counter
    current_trainingSet = subSets_training{j}; % Define current training set
    for i = 1:ceil(size(current_trainingSet,1)/counter) % accumulate observation #
        if counter < size(current_trainingSet,1)
            % Create tree
            trees{i,j} = fitctree(current_trainingSet(1:counter,:),strNames,...
                'AlgorithmForCategorical','PullLeft','PruneCriterion','impurity');
            counter = counter + 10;
        else
            % Create tree
            trees{i,j} = fitctree(current_trainingSet(1:end,:),strNames,...
                'AlgorithmForCategorical','PullLeft','PruneCriterion','impurity');
        end
        error_training(i,j) = resubLoss(trees{i,j}); % Training error
        error_validation(i,j) = loss(trees{i,j},subSets_validation{j}); % Validation error
    end
end

% Find variance between all models
modelsVar_training = mean(var(error_training,0,2)); % training variance
modelsVar_validation = mean(var(error_validation,0,2)); % validation variance

% Plot training and validation error
x = [10:10:1350, 1352];
figure
plot(x,mean(error_training,2)*100,'b'); % Plot training error
hold on
plot(x,mean(error_validation,2)*100,'r'); % Plot validation error
xlabel('Number of observations');
ylabel('Error (percentage)');
title('Error in trees without regularization');
xlim([10 1352]);
ylim([0 80]);
legend({'Training error' 'Validation error'});

%% Add regularization in the form of pruning - question 5

% Create cell array for all the pruned tree models
trees_pruned = cell(size(trees));
error_training_pruned = zeros(size(trees));
error_validation_pruned = zeros(size(trees));

% prune trees 
for j = 1:5
    for i = 1:size(trees,1) % accumulate observation #
        level = floor(0.75*max(trees{i,j}.PruneList)); % Find level of pruning
        trees_pruned{i,j} = prune(trees{i,j},'level',level); % prune trained trees
        error_training_pruned(i,j) = resubLoss(trees_pruned{i,j}); % training error
        error_validation_pruned(i,j) = loss(trees_pruned{i,j},subSets_validation{j}); % validation error
    end
end

% Find variance between all models
modelsVar_training_pruned = mean(var(error_training_pruned,0,2)); % training variance
modelsVar_validation_pruned = mean(var(error_validation_pruned,0,2)); % validation variance

% Plot training and validation error for pruned trees
x = [10:10:1350, 1352];
figure
plot(x,mean(error_training_pruned,2)*100,'b'); % Plot training error
hold on
plot(x,mean(error_validation_pruned,2)*100,'r'); % Plot validation error
xlabel('Number of observations');
ylabel('Error (percentage)');
title('Error in trees with regularization (pruned)');
xlim([10 1352]);
ylim([0 80]);
legend({'Training error' 'Validation error'});

%% Conduct grid serch to find optimal hyperparameters - question 6
% Create cell array for all the optimized tree models
treesOpt = cell(1,5);
error_trainingOpt = zeros(1,5);
error_validationOpt = zeros(1,5);

% Loop to create optimized tree models and find error for training and validation
for i = 1:5 % use all observation in training set
    current_trainingSet = subSets_training{i}; % Define current training set
    % create optimized tree models
    treesOpt{i} = fitctree(current_trainingSet,strNames,...
        'OptimizeHyperparameters','all','HyperparameterOptimizationOptions'...
        ,struct('optimizer','randomsearch', 'MaxObjectiveEvaluations',20));
    % prune optimized trees
    level = floor(0.75*max(treesOpt{i}.PruneList)); % Find level of pruning
    treesOpt{i} = prune(treesOpt{i},'level',level); % prune trained trees
    error_trainingOpt(i) = resubLoss(treesOpt{i}); % training error
    error_validationOpt(i) = loss(treesOpt{i},subSets_validation{i}); % validation error
end


%% Find the best tree model for future predictions - for questions 9 & 10

bestIndex = find(min(error_validationOpt)); % model with minimal validation error
bestTree = treesOpt{bestIndex}; % assign model to function output

