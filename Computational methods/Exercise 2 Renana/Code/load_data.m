function [data_train, data_test] = load_data(settings)
    rng(1)
	data = importdata(settings.path2data);
    mix_order = randperm(size(data,1));
    data = data(mix_order,:);
    test_size = 50;
    num_features = size(data,2)-1;
    num_samples = size(data,1);
        
    % Preprocessing:
    data_train.X = data(1:(num_samples-test_size),1:num_features);
    data_train.X = [ones((num_samples-test_size),1),data_train.X];
    data_train.Y = data(1:(num_samples-test_size),num_features+1);
    data_test.X = data(num_samples-test_size+1:end,1:num_features);
    data_test.X = [ones(test_size,1),data_test.X];
    data_test.Y = data(num_samples-test_size+1:end,num_features+1);
end