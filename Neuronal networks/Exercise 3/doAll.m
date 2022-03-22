% load data
load('BackPropData.mat');
%%
% The following code shows the first picture in the training set.
% TODO 1: Change it to show the first 10 images
for i = 1:10
figure;
imshow(reshape(x_train(i,:),[28,28])')
end
% Example of how to run backprop
[wInputHidden, xHiddenOutput, total_error_train, total_error_test] = ...
    backprop(x_train, y_train, x_test, y_test, 50 , 0.01, 0, 200);

%% Different Lambda

lambda_vec = [0.1,0.05,0.01,0.005,0.001,0.0005,0.0001];
for i = 1:7
    [wInputHidden, xHiddenOutput, total_error_train, total_error_test] = ...
    backprop(x_train, y_train, x_test, y_test, 50 , lambda_vec(i), 0, 200);
end

%% Different number of neurons

num_vec = [10, 50, 100, 200];
for i = 1:4
    [wInputHidden, xHiddenOutput, total_error_train, total_error_test] = ...
    backprop(x_train, y_train, x_test, y_test, num_vec(i) , 0.01, 0, 200);
end

%% Different alpha - 50 neurons

alpha_vec = [0.05,0.01,0.005,0.001];
for i = 1:4
    [wInputHidden, xHiddenOutput, total_error_train, total_error_test] = ...
    backprop(x_train, y_train, x_test, y_test, 50 , 0.01, alpha_vec(i), 300);
end

%% Optimal alpha - 200 neurons

[wInputHidden, xHiddenOutput, total_error_train, total_error_test] = ...
backprop(x_train, y_train, x_test, y_test, 200 , 0.01, 0.01, 300);


