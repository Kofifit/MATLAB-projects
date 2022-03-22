%% INIT
clear; close all; clc

%% Change seed in rng function

seed = [1, 2, 3, 4];
precision_seed = [];
precision_test_seed = [];

for run = 1:length(seed)
    % Settings & Parameters
    [settings, params] = load_settings_params();
    params.seed = seed(run);
    params.lambda = 0;
    params.max_epoch = params.max_epoch(1);    
    params.alpha = params.alpha(1);
    % Data
    [data_train, data_test] = load_data(settings);
    
    % Create title for figure
    title_fig = sprintf('Seed = %d, alpha = 0.1, epoch = 500',seed(run));

    % Train model
    model = train_model_hingeLoss(data_train, params,title_fig);
    % Predict
    prediction = predict_y(data_train.X, model.theta);
    % evaluate
    [precision_seed(run)] = evaluate_model(prediction, data_train.Y);

    % Predict Test
    prediction_test = predict_y(data_test.X, model.theta);         
    % evaluate Test
    [precision_test_seed(run)] = evaluate_model(prediction_test, data_test.Y);
end

%% Change Learning parameter alpha

[settings, params] = load_settings_params();
precision_alpha = [];
precision_test_alpha = [];

for run = 1:length(params.alpha) 
    
    % Settings & Parameters
    [settings, params] = load_settings_params();
    params.lambda = 0;
    params.max_epoch = params.max_epoch(1);    
    params.alpha = params.alpha(run);
    % Data
    [data_train, data_test] = load_data(settings);
    
    % Create title for figure
    title_fig = sprintf('Alpha = %d, epoch = 500',params.alpha);

    % Train model
    model = train_model_hingeLoss(data_train, params,title_fig);
    % Predict
    prediction = predict_y(data_train.X, model.theta);
    % evaluate
    [precision_alpha(run)] = evaluate_model(prediction, data_train.Y);

    % Predict Test
    prediction_test = predict_y(data_test.X, model.theta);         
    % evaluate Test
    [precision_test_alpha(run)] = evaluate_model(prediction_test, data_test.Y);
end
%% Change Number of Epochs

[settings, params] = load_settings_params();
precision_epoch = [];
precision_test_epoch = [];

for run = 1:length(params.max_epoch)
    
    % Settings & Parameters
    [settings, params] = load_settings_params();
    params.alpha = params.alpha(1);
    params.lambda = 0;    
    params.max_epoch = params.max_epoch(run);
    % Data
    [data_train, data_test] = load_data(settings);
    
    % Create title for figure
    title_fig = sprintf('Number epoch = %d, Alpha = 0.1',params.max_epoch);
    
    % Train model
    model = train_model_hingeLoss(data_train, params,title_fig);
    % Predict
    prediction = predict_y(data_train.X, model.theta);
    % evaluate
    [precision_epoch(run)] = evaluate_model(prediction, data_train.Y);

    % Predict Test
    prediction_test = predict_y(data_test.X, model.theta);         
    % evaluate Test
    [precision_test_epoch(run)] = evaluate_model(prediction_test, data_test.Y);
end
%% Stopping criteria

[settings, params] = load_settings_params();
precision_stop = [];
pecision_test_stop = [];

for run = 1:length(params.alpha) 
    
    % Settings & Parameters
    [settings, params] = load_settings_params();
    params.lambda = 0;
    params.max_epoch = params.max_epoch(1);    
    params.alpha = params.alpha(run);
    % Data
    [data_train, data_test] = load_data(settings);
    
    % Create title for figure
    title_fig = sprintf('Alpha = %d, epoch = 500',params.alpha);

    % Train model
    model = train_model_stop(data_train, params,title_fig);
    % Predict
    prediction = predict_y(data_train.X, model.theta);
    % evaluate
    [precision_stop(run)] = evaluate_model(prediction, data_train.Y);

    % Predict Test
    prediction_test = predict_y(data_test.X, model.theta);         
    % evaluate Test
    [precision_test_stop(run)] = evaluate_model(prediction_test, data_test.Y);
end

%% Change Regularization parameter lambda

[settings, params] = load_settings_params();
precision_lambda = [];
precision_test_lambda = [];

for run = 1:length(params.lambda)
    
    % Settings & Parameters    
    [settings, params] = load_settings_params();
    params.max_epoch = params.max_epoch(1);
    params.alpha = params.alpha(1);
    params.lambda = params.lambda(run);
    % Data
    [data_train, data_test] = load_data(settings);
    
    % Create title for figure
    title_fig = sprintf('Lambda = %d, Number epoch = 500, Alpha = 0.1',params.lambda);

    % Train model
    model = train_model_hingeLoss(data_train, params,title_fig);
    % Predict
    prediction = predict_y(data_train.X, model.theta);
    % evaluate
    [precision_lambda(run)] = evaluate_model(prediction, data_train.Y);

    % Predict Test
    prediction_test = predict_y(data_test.X, model.theta);         
    % evaluate Test
    [precision_test_lambda(run)] = evaluate_model(prediction_test, data_test.Y);
end

%% Sigmoid model

% Settings & Parameters
[settings, params] = load_settings_params();
params.alpha = params.alpha(1);
params.max_epoch = params.max_epoch(1);
% Data
[data_train, data_test] = load_data(settings);

% Create title for figure
title_fig = 'Logistic regression (sigmoid) - Alpha = 0.1, Number epoch = 500';
    
% Train model
model  = train_model_sigmoid(data_train, params,title_fig);
% Predict
prediction = predict_y(data_train.X, model.theta);
% evaluate
precision_sigmoid = evaluate_model(prediction, data_train.Y);

% Predict Test
prediction_test = predict_y(data_test.X, model.theta);         
% evaluate Test
precision_test_sigmoid = evaluate_model(prediction_test, data_test.Y);
