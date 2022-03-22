function [subSets_training,subSets_validation,data_train,data_test] = prepareData()

% This function loads and organizes the data. There is no input. The
% function changes the prediction from multiclass to binary. It creates
% five subsets of training and validation.
% The output is a table of training subsets, a table of validation subsets,
% a table of all training data and a table of test data.

%% Load and orgnaize

data_all = readtable('DataSet.csv'); % Load data 
labels = {'Insufficient_Weight','Normal_Weight','Overweight_Level_I',...
    'Overweight_Level_II','Obesity_Type_I','Obesity_Type_II','Obesity_Type_III'};

% Loop to change output from nulticlass to binary
newOutput = zeros(2111,1);
for i = 1:7
    Index = strcmp(table2array(data_all(:,17)), labels{i}); % Find indices of current label
    if i < 4 % First three labels change to 0
        newOutput(Index) = 0;
    elseif i == 4 % Forth label set randomly 0 or 1
        newOutput(Index) = randi([0,1]);
    elseif i > 4 % Last three labels change to 1
        newOutput(Index) = 1;
    end
end

NObeyesdad = array2table(newOutput); % Create new otput variable for table
data_all.NObeyesdad = NObeyesdad{:,1}; % Change output column to binary
data_random = data_all(randperm(size(data_all, 1)), :); % Randomize data order
set_size = size(data_random,1); % Find size of data
data_test = data_random(1:floor(set_size*0.2),:); % Create test set - 20 precent
data_train = data_random(ceil(set_size*0.2):end,:); % Create training set - 80 precent

%% Divide data to 5 validation and training subsets

subSets_validation = cell(1,5); % create cell array for validation subsets
subSets_training = cell(1,5); % create cell array for training subsets
counter = 1; 
for i = 1:5 % loop to create 5 validation subsets from the training set (data_train)
    if i ~= 5
        until = counter + floor(size(data_train,1)/5);
        subSets_validation{i} = data_train(counter:until,:);
        counter = until + 1;
    else
        subSets_validation{i} = data_train(counter:end,:);  
    end
end

index_vec = [1 2 3 4 5]; % Index vector
for i = 1:5 % Loop to create 5 training subsets
    current_set = []; % Define current training set
    current_index = index_vec; % create index vector
    current_index(current_index == i) = []; % remove current validation index
    for j = 1:4 % Create current training set
        current_set = [current_set;subSets_validation{current_index(j)}];
    end
    subSets_training{i} = current_set; % assign current training set to cell
end
