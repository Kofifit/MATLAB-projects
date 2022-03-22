function model = train_model_hingeLoss(data, params,title_fig)
%% Initialize
rng(params.seed)

[num_samples, num_features] = size(data.X);
% initialize W to random values

theta =  rand(1,num_features);

%% SGD with hinge-loss
figure;
clf; hold on
title(title_fig);
xlabel('learning epoch'); ylabel('train error');
error = [];
counter = 0;
for epoch = 1:params.max_epoch
    fprintf('\nEpoch #%i: ', epoch)
    
    % Arrange samples in random order for each learning epoch
    epoch_order = randperm(num_samples);
    % Initialize the error
    error(epoch) = 0;
    
    % we will use stochastic gradient descent to train our model
    for iter = 1:num_samples
        % Get current sample
        sample_index = epoch_order(iter);
        current_sample = data.X(sample_index,:); 
        current_label = data.Y(sample_index); 
        % Update weights
        condition = dot(theta,current_sample)*current_label-params.lambda*sum(theta.^2);
        if condition <= 0
            error(epoch) = error(epoch)-condition; 
            change_vec = current_sample.*(-current_label) + 2*params.lambda.*theta;
            theta = theta - params.alpha.*change_vec;
        end
    end 
    
    error(epoch) = error(epoch)/num_samples; % normalize error
    
    % Plot average error
    if epoch>params.convergence_window
        plot(epoch, mean(error(epoch-params.convergence_window:epoch)), '.', 'MarkerSize', 10)
        drawnow
    elseif params.max_epoch <= params.convergence_window
        plot(epoch,error(epoch),'.','MarkerSize',10);
        drawnow
    end

end

%% Output model
model.theta = theta;
model.training_error = error;
model.num_of_epochs = epoch;
end